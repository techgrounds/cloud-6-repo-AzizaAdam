@description('The location into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The Tenant Id that should be used throughout the deployment.')
param tenantsubid string = subscription().tenantId

param environment string = 'test'
param diskencrypsetname string = 'encrypset${environment}'

@description('The name of the User Assigned Identity.')
param userAssignedIdentityName string= 'userid${uniqueString(resourceGroup().name)}' 
param policyoperation string = 'add'
@description('The name of the Key Vault.')
param keyVaultName string = 'keyVault${uniqueString(resourceGroup().name)}' 

@description('Name of the key in the Key Vault')
param keyVaultKeyName string = 'key${uniqueString(resourceGroup().name)}' 
param diskencryptId string = diskencrypsetname


// adding keyvault
resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 9
    enableRbacAuthorization: false
    enablePurgeProtection: true
    publicNetworkAccess: 'Enabled'

    tenantId: tenantsubid
    accessPolicies: [
      {
        tenantId: tenantsubid
        permissions: {
          keys: [
            'get'
            'list'
            'update'
            'create'
            'import'
            'delete'
            'recover'
            'backup'
            'restore'
            'getrotationpolicy'
            'setrotationpolicy'
            'rotate'
          ]
          secrets: [
            'get'
            'list'
            'set'
            'delete'
            'recover'
            'backup'
            'restore'
          ]
          certificates: [
            'get'
            'list'
            'update'
            'create'
            'import'
            'delete'
            'recover'
            'backup'
            'restore'
            'managecontacts'
            'manageissuers'
            'getissuers'
            'listissuers'
            'setissuers'
            'deleteissuers'
          ]
        }
          objectId: userAssignedIdentity.properties.principalId
      }
    ]
    networkAcls:{
      defaultAction: 'Allow'
      bypass:'AzureServices'
    }
  }
}

// creating keys for the keyvault
resource kvKey 'Microsoft.KeyVault/vaults/keys@2021-06-01-preview' = {
  parent: keyVault
  name: keyVaultKeyName
  properties: {
    attributes: {
      enabled: true
    }
    keySize: 4096
    kty: 'RSA'
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'unwrapKey'
      'verify'
      'wrapKey'
    ]
  }
}


// adding diskencryptionset
resource diskencrptionset 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: diskencrypsetname
  location: location
  identity:{
    type: 'SystemAssigned'
  }
  properties:{
    activeKey:{
      sourceVault:{
        id: keyVault.id
      }
      keyUrl: kvKey.properties.keyUriWithVersion
    }
  }
}
output diskencryptId_out string = diskencrptionset.id
// adding userassigned identity
resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: userAssignedIdentityName
  location: location
}
output userAssignedIdentity string = userAssignedIdentity.properties.principalId
output managedId_out string = userAssignedIdentity.id

// adding access polies to the keyvault
resource accesspolies_vault 'Microsoft.KeyVault/vaults/accessPolicies@2021-10-01' = {
  name: policyoperation
  parent: keyVault
  properties: {
    accessPolicies:[
      {
        tenantId: tenantsubid
        objectId: diskencryptId
        permissions: {
          keys: [
            'get'
            'wrapKey'
            'unwrapKey'
            'encrypt'
            'decrypt'
          ]
          secrets: []
          certificates: []
        }

      }
      {
        tenantId: tenantsubid
        objectId: userAssignedIdentity.properties.principalId
        permissions: {
          keys: [
            'get'
            'list'
            'unwrapKey'
            'wrapKey'
          ]
          secrets: []
          certificates: []
        }
      }
    ]
  }
}

