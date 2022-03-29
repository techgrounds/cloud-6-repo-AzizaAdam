// this the command to run this main.bicep file  >> az deployment sub create --location westeurope --template-file mainfile-version1.bicep
// all modules depoly successfully
// https://app.diagrams.net/ link to make the design of the project
targetScope = 'subscription'
param environment string = 'test32'
param resourceGname string = 'rg${uniqueString(environment)}'
param location string = deployment().location 


resource projectresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name:resourceGname
  location:location
  tags: {
    tagName1: 'testing'
    tagName2: 'v1.0'
  }
  managedBy: 'string'
  properties: {} 
}

 // Vnet module
module moduleVnet_MPV1 'moduleVnet1.bicep'= {
  scope: projectresourcegroup
  name: 'module-vnet-MVP1.0'
  params: {
    location:location
  }
}


// storage and encryption module
module module_encryption_MVP1 'module-encryp1.bicep'= {
  scope: projectresourcegroup
  name: 'module-encryption-MVP1.0'
  params: {
    location:location
  }
}



// module virtual machines
module virtual_machines 'moduleVMs1.bicep' = {
  scope: projectresourcegroup
  name: 'module-virtual-machines-MVP1.0'
  params: {
    location:location
    adminPasswordOrKey: 'Mynameisaziza@777'
    adminUsername: 'ziza'
    diskencryptId: module_encryption_MVP1.outputs.diskencryptsetId
    nicadminId: moduleVnet_MPV1.outputs.nicadminId
    nicwebserver_out: moduleVnet_MPV1.outputs.nic_webserver_out
  }
}


// module backup and recoveryvault
module backup_recovery 'module-backup1.bicep'= {
  scope: projectresourcegroup
  name: 'module-backup-MVP1.0'
  params: {
    location:location
    vm_admin_ID_out:virtual_machines.outputs.vm_admin_ID_out
    vm_admin_NAME_out: virtual_machines.outputs.vm_admin_NAME_out
    vm_web_NAME_out: virtual_machines.outputs.vm_web_NAME_out
    vmWebApp_ID_out: virtual_machines.outputs.vmWebApp_ID_out
  }
}
