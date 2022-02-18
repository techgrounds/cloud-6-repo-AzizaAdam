targetScope = 'subscription'
resource AppProject 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'test1'
  location: 'eastus'
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  managedBy: 'aziza'
  properties: {} 
}

