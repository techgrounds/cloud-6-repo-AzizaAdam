resource symbolicname 'Microsoft.Compute/virtualMachines/extensions@2021-07-01' = {
  name: 'string'
  location: 'string'
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  parent: resourceSymbolicName
  properties: {
    autoUpgradeMinorVersion: bool
    enableAutomaticUpgrade: bool
    forceUpdateTag: 'string'
    instanceView: {
      name: 'string'
      statuses: [
        {
          code: 'string'
          displayStatus: 'string'
          level: 'string'
          message: 'string'
          time: 'string'
        }
      ]
      substatuses: [
        {
          code: 'string'
          displayStatus: 'string'
          level: 'string'
          message: 'string'
          time: 'string'
        }
      ]
      type: 'string'
      typeHandlerVersion: 'string'
    }
    protectedSettings:  {
      "AADClientID": "[aadClientID]",
      "DiskFormatQuery": "[diskFormatQuery]",
      "EncryptionOperation": "[encryptionOperation]",
      "KeyEncryptionAlgorithm": "[keyEncryptionAlgorithm]",
      "KeyEncryptionKeyURL": "[keyEncryptionKeyURL]",
      "KeyVaultURL": "[keyVaultURL]",
      "SequenceVersion": "sequenceVersion]",
      "VolumeType": "[volumeType]"
    }
    publisher: 'string'
    settings:  {
      "AADClientID": "[aadClientID]",
      "DiskFormatQuery": "[diskFormatQuery]",
      "EncryptionOperation": "[encryptionOperation]",
      "KeyEncryptionAlgorithm": "[keyEncryptionAlgorithm]",
      "KeyEncryptionKeyURL": "[keyEncryptionKeyURL]",
      "KeyVaultURL": "[keyVaultURL]",
      "SequenceVersion": "sequenceVersion]",
      "VolumeType": "[volumeType]"
    }
    suppressFailures: bool
    type: 'string'
    typeHandlerVersion: 'string'
  }
}
