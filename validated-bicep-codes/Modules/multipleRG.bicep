//az deployment sub create --location westeurope --template-file multipleRG.bicep 
targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test51'
  'test52'
  'test53'
  'test54'
  'test55'
  'test56'
  'test57'
  'test58'
  'test59'
  'test60'
  'test61'
  'test62'
  'test63'
  'test64'

]


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}]
