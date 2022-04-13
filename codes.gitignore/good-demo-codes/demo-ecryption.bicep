param environment string
param location string
param versiontag object

param vaultname string = 'kv-${uniqueString(resourceGroup().id)}'
param tenantsubid string = subscription().tenantId
param diskencrypsetname string = 'encrypset${environment}'
param managedidname string = 'iden-${environment}'
param policyoperation string = 'add'


resource vault_sym_link 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: vaultname
  location: location
  tags: versiontag
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenantsubid
    accessPolicies: [
      {
        tenantId: tenantsubid
        objectId: '176f8a4b-086b-4432-b804-1e123c04855b'
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
    ]
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 9
    enableRbacAuthorization: false
    enablePurgeProtection: true
    publicNetworkAccess: 'Enabled'

    networkAcls:{
      defaultAction: 'Allow'
      bypass:'AzureServices'
    }
  }
}
resource diskencrypsetsym_link 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: diskencrypsetname
  location: location
  tags: versiontag
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    activeKey: {
      sourceVault: {
        id: vault_sym_link.id
      }
      keyUrl: vaultkeysym_link.properties.keyUriWithVersion
    }
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: true
  }
  
}

resource vaultkeysym_link 'Microsoft.KeyVault/vaults/keys@2021-11-01-preview' = {
  parent: vault_sym_link
  name: 'encryptkeyall'
  tags: versiontag
  properties: {
    kty: 'RSA'
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'unwrapKey'
      'verify'
      'wrapKey'
    ]
    keySize: 4096
  }
}

resource managedidsym_link 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedidname
  location: location
  tags: versiontag
  dependsOn: [
    vault_sym_link
  ]
}

resource accesspsym_link 'Microsoft.KeyVault/vaults/accessPolicies@2021-10-01' = {
  name: policyoperation
  parent: vault_sym_link
  properties: {
    accessPolicies:[
      {
        tenantId: tenantsubid
        objectId: diskencrypsetsym_link.identity.principalId
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
        tenantId: tenantsubid
        objectId: managedidsym_link.properties.principalId
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

output diskencrypt_IDout string = diskencrypsetsym_link.id
output kvurl_out string = vault_sym_link.properties.vaultUri
output manidentityID_out string = managedidsym_link.id
