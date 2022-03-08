
// https://www.youtube.com/watch?v=F5OFOH1u2lE
// the targetscope for this file 
targetScope = 'subscription'
param location string = 'westeurope'
var resourcegroup_name = 'mynewtesting' 

resource demoresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name:resourcegroup_name
  location:location
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  managedBy: 'string'
  properties: {} 
}

