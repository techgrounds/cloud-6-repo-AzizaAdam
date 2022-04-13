param vaults_keyvault77909_name string = 'kv1982'
param virtualnetworks_vnet_subnet1_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/project/providers/microsoft.network/virtualnetworks/vnet-subnet1'
param virtualnetworks_vnet_subnet2_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/project/providers/microsoft.network/virtualnetworks/vnet-subnet2'

resource vaults_keyvault77909_name_resource 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: vaults_keyvault77909_name
  location: 'westeurope'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      virtualNetworkRules: [
        {
          id: '${virtualnetworks_vnet_subnet1_externalid}/subnets/default'
          ignoreMissingVnetServiceEndpoint: false
        }
        {
          id: '${virtualnetworks_vnet_subnet2_externalid}/subnets/default'
          ignoreMissingVnetServiceEndpoint: false
        }
      ]
    }
    accessPolicies: [
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: '2ac95fd8-9277-4adb-80c8-af41d0c73dad'
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
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: '0c9e9953-88ce-4c99-ab40-441e61a26060'
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
            'decrypt'
            'encrypt'
            'unwrapKey'
            'wrapKey'
            'verify'
            'sign'
            'purge'
            'rotate'
            'getrotationpolicy'
            'setrotationpolicy'
          ]
          secrets: [
            'get'
            'list'
            'set'
            'delete'
            'recover'
            'backup'
            'restore'
            'purge'
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
            'purge'
          ]
        }
      }
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: 'ee09dadb-e944-4392-a486-562c4d7732c7'
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
            'decrypt'
            'encrypt'
            'unwrapKey'
            'wrapKey'
            'verify'
            'sign'
            'purge'
            'rotate'
            'getrotationpolicy'
            'setrotationpolicy'
          ]
          secrets: [
            'get'
            'list'
            'set'
            'delete'
            'recover'
            'backup'
            'restore'
            'purge'
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
            'purge'
          ]
        }
      }
    ]
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: false
    enablePurgeProtection: true
    vaultUri: 'https://${vaults_keyvault77909_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

