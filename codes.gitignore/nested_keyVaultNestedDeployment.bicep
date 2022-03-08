var vaultName = 'keyvault77909'
var keyName = 'encryptionDisckey'

resource keyvault77909_encryptionDisckey 'Microsoft.KeyVault/vaults/keys@2019-09-01' = {
  name: 'keyvault77909/encryptionDisckey'
  location: 'westeurope'
  properties: {
    curveName: null
    keySize: 2048
    kty: 'RSA'
    attributes: {
      enabled: true
      exp: null
      nbf: null
    }
  }
  dependsOn: []
}