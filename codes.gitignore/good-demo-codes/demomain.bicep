// Resource group must be createdon Subcription level. Modules are then deployed with the created resource group as their scope.
targetScope = 'subscription'
param rsgname string = 'rsgprojectv1.05-${environment}'

// Home/Office IP that will have access to admin server. Current value was for testing, please update. If multiple IPs need to be giving access, please simply add a list to this array.
param admintrust array = [
  '82.169.176.78'
]

// Sample key data, please adjust the urls to point to a new location or simply provide the data as a string.
param pubkey string = loadTextContent('./TestKeys/linwebkey.pub') // sample test data
param passadmin string = loadTextContent('./TestKeys/admin_pass.txt') // sample test data

param environment string = 'test'
param location string = deployment().location 
param versiontag object = {
  project_version: '1.0'
}

resource resourcegproject 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name : rsgname
  location : location
}

module networkmod 'modules/network.bicep' = {
  name: 'network_module'
  scope: resourcegproject
  params:{
    admintrust: admintrust
    versiontag: versiontag
    location: location
    environment: environment
  }
}

module vaultmod 'modules/vault_key.bicep' = {
  name: 'vault_key_module'
  scope: resourcegproject
  params:{
    versiontag: versiontag
    location: location
    environment: environment
  }
}

module machines 'modules/machines.bicep' = {
  name: 'machine_module'
  scope: resourcegproject
  params:{
    environment: environment
    versiontag: versiontag
    location: location
    pubkey: pubkey
    passadmin: passadmin
    diskencryptId: vaultmod.outputs.diskencrypt_IDout
    nic_id_admin: networkmod.outputs.nic_admin_out
    nic_id_webserver: networkmod.outputs.nic_webserver_out
  }
}

module storeboot 'modules/storeboot.bicep' = {
  name: 'storeboot_module'
  scope: resourcegproject
  params:{
    environment: environment
    location: location
    kvult: vaultmod.outputs.kvurl_out
    manindentity: vaultmod.outputs.manidentityID_out
  }
}

module recover 'modules/recovery.bicep' = {
  name: 'recovery_module'
  scope: resourcegproject
  params:{
    environment: environment
    location: location
    versiontag: versiontag
    vm_web_ID_in:  machines.outputs.vm_web_ID_out
    vm_web_NAME_in: machines.outputs.vm_web_NAME_out
    vm_admin_ID_in:  machines.outputs.vm_admin_ID_out
    vm_admin_NAME_in: machines.outputs.vm_admin_NAME_out
  }
}
