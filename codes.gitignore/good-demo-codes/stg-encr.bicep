param userAssignedIdentities_name string = 'identitydeom1'

resource userAssignedIdentities 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: userAssignedIdentities_name
  location: location
}

output userAssignedIdentities object = {}
output managed_id_access string = userAssignedIdentities.properties.principalId
output userAssignedIdentities_out string = resourceId('88ad0edb-f4f4-4dda-8d16-c6d5c372bef3','demo1','providers/Microsoft.ManagedIdentity/userAssignedIdentities/identitydeom1')


param location string = resourceGroup().location
param sku_name string = 'Standard_LRS'
param sku_tier string = 'Standard'
param kind string = 'StorageV2'


@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string = 'TLS1_0'

var storageaccount_prefix = 'test'
var storageaccount_name = '${storageaccount_prefix}${uniqueString(resourceGroup().name)}'



resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageaccount_name
  location: location
  sku: {
    name: sku_name
    tier: sku_tier
  }
  kind: kind
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
        '${userAssignedIdentities.id}': {}
      }
    }

  properties: {
    minimumTlsVersion: minimumTlsVersion
    allowBlobPublicAccess: false
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      identity: {
        userAssignedIdentity: userAssignedIdentities.id    
      }
      keyvaultproperties: {
        keyvaulturi: 'https://kv1982.vault.azure.net'
        keyname: 'kv1982'
      }
      services: {
        file: {
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

resource blob 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  parent: storageAccount
  name: 'default'
  sku: {
    name: sku_name
    tier: sku_tier
  }
  properties: {
        deleteRetentionPolicy: {
      enabled: false
    }
  }
}

resource tableService 'Microsoft.Storage/storageAccounts/tableServices@2021-08-01'= {
  parent: storageAccount
  name: 'default'
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' = {
  parent: blob
  name: 'bootstrap'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
}
