// add stroageAccount (custom-managed-encryption), blobstorage and a container for bootstrap 
@description('The location into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The Tenant Id that should be used throughout the deployment.')
param tenantsubid string = subscription().tenantId


param environment string = 'test'

@description('The name of the Key Vault.')
param keyVaultName string = 'keyVault${uniqueString(resourceGroup().name)}' 

@description('Name of the key in the Key Vault')
param keyVaultKeyName string = 'key${uniqueString(resourceGroup().name)}' 

param diskencrypsetname string = 'encrypset${environment}'
param policyoperation string = 'add'

@description('The name of the Storage Account')
param storageAccountName string = 'store${uniqueString(resourceGroup().id)}'


resource storage 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
    sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentity}': {}
      }
    }
  
  properties: {
    defaultToOAuthAuthentication: false
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_0'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      identity: {
        userAssignedIdentity: userAssignedIdentity.id
      }
      requireInfrastructureEncryption: false
      keyvaultproperties: {
        keyvaulturi: keyVault.properties.vaultUri
        keyname: kvKey.name 
      }
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        table: {
          keyType: 'Account'
          enabled: true
        }
        queue: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Keyvault'
    }
    accessTier: 'Hot'
  }
}

resource store_blob 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  parent: storage
  name: 'default'
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }

    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}


