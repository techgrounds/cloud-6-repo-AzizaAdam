param storageAccounts_stgtest8989_name string = 'stgtest8989'
param vaults_keyVaulthypf3t2h23bdi_name string = 'keyVaulthypf3t2h23bdi'
param diskEncryptionSets_encrypsettest_name string = 'encrypsettest'
param userAssignedIdentities_useridhypf3t2h23bdi_name string = 'useridhypf3t2h23bdi'

resource vaults_keyVaulthypf3t2h23bdi_name_resource 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: vaults_keyVaulthypf3t2h23bdi_name
  location: 'westeurope'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
    accessPolicies: [
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
      }
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: 'd73be657-b737-4b1e-86d1-cd3b6a3516a6'
        permissions: {
          keys: [
            'get'
            'wrapKey'
            'unwrapKey'
          ]
          secrets: []
          certificates: []
        }
      }
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: '73780064-3157-405c-8f1c-4dff276497c9'
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
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 9
    enableRbacAuthorization: false
    enablePurgeProtection: true
    vaultUri: 'https://keyvaulthypf3t2h23bdi.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource userAssignedIdentities_useridhypf3t2h23bdi_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: userAssignedIdentities_useridhypf3t2h23bdi_name
  location: 'westeurope'
}

resource diskEncryptionSets_encrypsettest_name_resource 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: diskEncryptionSets_encrypsettest_name
  location: 'westeurope'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    activeKey: {
      sourceVault: {
        id: vaults_keyVaulthypf3t2h23bdi_name_resource.id
      }
      keyUrl: 'https://keyvaulthypf3t2h23bdi.vault.azure.net/keys/keyhypf3t2h23bdi/ce5705caab3c436ca42846353f4c020f'
    }
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: true
  }
}

resource vaults_keyVaulthypf3t2h23bdi_name_keyhypf3t2h23bdi 'Microsoft.KeyVault/vaults/keys@2021-11-01-preview' = {
  parent: vaults_keyVaulthypf3t2h23bdi_name_resource
  name: 'keyhypf3t2h23bdi'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource storageAccounts_stgtest8989_name_resource 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccounts_stgtest8989_name
  location: 'westeurope'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/test8/providers/Microsoft.ManagedIdentity/userAssignedIdentities/useridhypf3t2h23bdi': {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        identityUrl: 'https://control-westeurope.identity.azure.net/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourcegroups/test8/providers/Microsoft.Storage/storageAccounts/stgtest8989/credentials/v2/userassigned?arpid=eee4bc0c-b333-4370-aba0-40083be36159&uaid=769f8cff-3432-4df7-b337-010ee503badd&tid=de60b253-74bd-4365-b598-b9e55a2b208d'
        certRenewAfter: '2022-04-19T12:59:00Z'
      }
    }
  }
  properties: {
    defaultToOAuthAuthentication: false
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
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
        userAssignedIdentity: userAssignedIdentities_useridhypf3t2h23bdi_name_resource.id
      }
      requireInfrastructureEncryption: false
      keyvaultproperties: {
        keyvaulturi: 'https://keyvaulthypf3t2h23bdi.vault.azure.net'
        keyname: 'keyhypf3t2h23bdi'
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

resource storageAccounts_stgtest8989_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  parent: storageAccounts_stgtest8989_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
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
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_stgtest8989_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-08-01' = {
  parent: storageAccounts_stgtest8989_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_stgtest8989_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-08-01' = {
  parent: storageAccounts_stgtest8989_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stgtest8989_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-08-01' = {
  parent: storageAccounts_stgtest8989_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}