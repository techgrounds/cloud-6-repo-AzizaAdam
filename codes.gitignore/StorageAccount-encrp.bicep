param storageAccounts_name string = 'demostorageaccount'

resource storageAccounts_name_resource 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: 'demostorageaccount'
  location: 'westeurope'
  tags: {
    project: 'st'
  }
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  
    properties:{
    defaultToOAuthAuthentication: false
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
      supportsHttpsTrafficOnly: true
    }

encryption: {
      identity: {
        userAssignedIdentity: true
      }
      requireInfrastructureEncryption: true
      keyvaultproperties: {
        keyvaulturi: 'https://kv1982.vault.azure.net/'
        keyname: 'encryptionDisckey'
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
    accessTier: 'Cool'
  }
}

resource storageAccounts_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  parent: storageAccounts_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: true
    changeFeed: {
      retentionInDays: 7
      enabled: true
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

