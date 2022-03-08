param location string = resourceGroup().location
param encryptionkeysetsName string= 'encryptionketset${uniqueString(resourceGroup().name)}'
 

resource diskEncryptionSets 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: encryptionkeysetsName
  location: location
  tags: {
    project: 'encryptionSet'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    activeKey: {
      sourceVault: {
        id: keyVault.id
      }
    }
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: true
  }
}
