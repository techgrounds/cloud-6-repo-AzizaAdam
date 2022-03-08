//az deployment sub create --location westeurope --template-file multipleRG.bicep
// Resource group

targetScope = 'subscription'
param environment string = 'test'
param resourceGname string = 'rg${environment}'


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
 // vnet module
module modulevnet 'modulevnet.bicep' = {
  name: 'network_module'
  scope: projectresourcegroup
  params:{
    location: location
    environment: environment
    pubkey:'noidea'
    passadmin: 'ziza'
    diskencryptId:
  }
}

// encryption moduel (keyvault, encryptionkeysets, managedId, storage account with customer managed encryption)
module module_encrp_stg 'module.good-stg-encrp.bicep' = {
  name: 'encrp_module'
  scope: projectresourcegroup
  params:{
    location: location
  }
}


