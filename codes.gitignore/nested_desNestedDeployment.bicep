param apiVersion string
param name string
param location string
param keyVaultId string
param keyUrl string
param encryptionType string
param autoKeyRotation bool

resource name_resource 'Microsoft.Compute/diskEncryptionSets@[parameters(\'apiVersion\')]' = {
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    activeKey: {
      sourceVault: {
        id: keyVaultId
      }
      keyUrl: reference('/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/project/providers/Microsoft.KeyVault/vaults/keyvault77909/keys/encryptionDisckey', '2019-09-01').keyUriWithVersion
    }
    encryptionType: encryptionType
    rotationToLatestKeyVersionEnabled: autoKeyRotation
  }
  tags: {
    project: 'encryptionSet'
  }
  dependsOn: []
}