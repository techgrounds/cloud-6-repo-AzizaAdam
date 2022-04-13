// validated bicep file good to use
param vaultName string = 'keyVault${uniqueString(resourceGroup().id)}' // must be globally unique
param location string = resourceGroup().location
param sku string = 'Standard'
param tenant string = 'de60b253-74bd-4365-b598-b9e55a2b208d' // replace with your tenantId
param accessPolicies array = [
  {
    tenantId: tenant
    objectId: '88ad0edb-f4f4-4dda-8d16-c6d5c372bef3' // replace with your objectId
    permissions: {
      keys: [
        'Get'
        'List'
        'Update'
        'Create'
        'Import'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
      ]
      secrets: [
        'Get'
        'List'
        'Set'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
      ]
      certificates: [
        'Get'
        'List'
        'Update'
        'Create'
        'Import'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
        'ManageContacts'
        'ManageIssuers'
        'GetIssuers'
        'ListIssuers'
        'SetIssuers'
        'DeleteIssuers'
      ]
    }
  }
]

param enabledForDeployment bool = true
param enabledForTemplateDeployment bool = true
param enabledForDiskEncryption bool = true
param enableRbacAuthorization bool = false
param softDeleteRetentionInDays int = 90

param keyName string = 'ProdKey'
param secretName string = 'bankAccountPassword'
param secretValue string = '12345'

param networkAcls object = {
  ipRules: []
  virtualNetworkRules: []
}

resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: vaultName
  location: location
  properties: {
    tenantId: tenant
    sku: {
      family: 'A'
      name: sku
    }
    accessPolicies: accessPolicies
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    softDeleteRetentionInDays: softDeleteRetentionInDays
    enableRbacAuthorization: enableRbacAuthorization
    networkAcls: networkAcls
  }
}

// create key
resource key 'Microsoft.KeyVault/vaults/keys@2019-09-01' = {
  name: '${keyvault.name}/${keyName}'
  properties: {
    kty: 'RSA' // key type
    keyOps: [
      // key operations
      'encrypt'
      'decrypt'
    ]
    keySize: 4096
  }
}

// create secret
resource secret 'Microsoft.KeyVault/vaults/secrets@2018-02-14' = {
  name: '${keyvault.name}/${secretName}'
  properties: {
    value: secretValue
  }
}

output proxyKey object = key

// adding bicep code for managedId
param managedId_name string = 'validationid'

resource userAssignedIdentities 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedId_name
  location: location
}

output managed_id string = userAssignedIdentities.id
output managed_id_access string = userAssignedIdentities.properties.principalId

// https://ochzhen.com/tags/#infrastructure-as-code




