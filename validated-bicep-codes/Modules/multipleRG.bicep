targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test23'
  'test24'
  'test25'
  'test26'
  'test27'
  'test28'
  'test29'
  'test30'
  'test31'
  'test32'
  'test33'
  'test34'
  'test35'
  'test36'

]


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}]
