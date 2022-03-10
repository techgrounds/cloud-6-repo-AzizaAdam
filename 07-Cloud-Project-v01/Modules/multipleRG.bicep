//az deployment sub create --location westeurope --template-file multipleRG.bicep 
targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test65'
  'test66'
  'test67'
  'test68'
  'test69'
  'test70'
  'test71'
  'test72'
  'test73'
  'test74'
  'test75'
  'test76'
  'test77'
  'test78'
  'test79'
  'test80'

]


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}]
