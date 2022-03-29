// this the command to run this main.bicep file  >> az deployment sub create --location westeurope --template-file main.bicep
// all modules deploy successfully
// https://app.diagrams.net/ link to make the design of the project
targetScope = 'subscription'
param environment string = 'test30'
param resourceGname string = 'rg${uniqueString(environment)}'
param location string = deployment().location 


resource projectresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name:resourceGname
  location:location
  tags: {
    tagName1: 'testing'
    tagName2: 'v1.1'
  }
  managedBy: 'string'
  properties: {} 
}

 // Vnet module
module moduleVnet 'moduleVnet2.bicep' = {
  name: 'Vnetwork_module'
  scope: projectresourcegroup
  params:{    
    location: location
    environment: environment
  }
}


// Admin server module
module moduleAdminserver 'module-adminserv.bicep' = {
  scope: projectresourcegroup
  name: 'adminServer_module'
  params:{
    adminUsername:'ziza'
    diskencryptId:moduleSTG_encryption.outputs.diskencryptionId
    nicadminId:moduleVnet.outputs.nicadminId
    location:location
    passadmin:'Mynameis@aziza123'
  }
  }


// storage and encryption module
module moduleSTG_encryption 'module-stg-encrp2.bicep'= {
  scope: projectresourcegroup
  name: 'module_storage_encryp'
  params:{
    location: location    
    policyoperation:'add'
  }
}


// module virtual machine scalesets and application gateway
module vmss_AGW 'module-vmss-AGW.bicep' = {
  scope: projectresourcegroup
  name: 'module_vmss_AGW'
  params: {
    diskencryptionId:moduleSTG_encryption.outputs.diskencryptionId
    AGWPipId: moduleVnet.outputs.AGWPipId
    AGWSubnetId: moduleVnet.outputs.AGWSubnetId
    vmssSubnetId: moduleVnet.outputs.vmssSubnetId
    location: location
  }
}


// module backup and recoveryvault
module backup_recoveryVault 'module-backup-recovault.bicep' = {
  scope: projectresourcegroup
  name: 'module_backup_recoveryVault'
  params: {
    location:location
    vmAdmin_windowsId: moduleAdminserver.outputs.vmAdmin_windowsId
    vmAdmin_windowsName: moduleAdminserver.outputs.vmAdmin_windowsName
  }
}
