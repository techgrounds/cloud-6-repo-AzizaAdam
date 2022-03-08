//az deployment sub create --location westeurope --template-file multipleRG.bicep 
targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test37'
  'test38'
  'test39'
  'test40'
  'test41'
  'test42'
  'test43'
  'test44'
  'test45'
  'test46'
  'test47'
  'test48'
  'test49'
  'test50'

]


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}]
