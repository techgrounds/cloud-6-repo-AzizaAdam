resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: 'demostorsgeaccount'
  location: 'west europe'
  sku: {
    name: 'Standard_LRS' 
  }
  kind: 'BlobStorage'
  properties: {
    accessTier: 'Hot'
  }
  
}
