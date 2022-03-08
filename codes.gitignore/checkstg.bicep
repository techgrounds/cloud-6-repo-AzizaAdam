param storageAccounts_name string = 'demostorageaccountx'

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
  }
}
