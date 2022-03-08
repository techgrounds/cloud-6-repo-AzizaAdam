param storageAccounts_demostorsgeaccount_name string = 'demostorsgeaccount'
param userAssignedIdentities_identitydeom1_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/demo1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identitydeom1'

resource storageAccounts_demostorsgeaccount_name_resource 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccounts_demostorsgeaccount_name
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'BlobStorage'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/demo1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identitydeom1': {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        identityUrl: 'https://control-westeurope.identity.azure.net/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourcegroups/demo1/providers/Microsoft.Storage/storageAccounts/demostorsgeaccount/credentials/v2/userassigned?arpid=f1cc9685-01ef-4bd7-9942-bb9e04fee0f3&uaid=f8063cf3-666b-46b0-b780-52e07abb653c&tid=de60b253-74bd-4365-b598-b9e55a2b208d'
        certRenewAfter: '2022-04-09T11:47:00Z'
      }
    }
  }
  properties: {
    minimumTlsVersion: 'TLS1_0'
    allowBlobPublicAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      identity: {
        userAssignedIdentity: userAssignedIdentities_identitydeom1_externalid
      }
      keyvaultproperties: {
        keyvaulturi: 'https://kv1982.vault.azure.net'
        keyname: 'stgencrtption'
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

resource storageAccounts_demostorsgeaccount_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  parent: storageAccounts_demostorsgeaccount_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_demostorsgeaccount_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-08-01' = {
  parent: storageAccounts_demostorsgeaccount_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}
