//az deployment sub create --location westeurope --template-file multipleRG.bicep 
targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test145'
  'test146'
  'test147'
  'test148'
  'test149'
  'test150'
  'test151'
  'test152'
  'test153'
  'test154'
  'test155'
  'test156'
  'test157'
  'test158'
  'test159'
  'test160'

]


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}]
