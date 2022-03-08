
// the targetscope for this file 
targetScope = 'subscription'
param environment string = 'test'
param resourceGname string = 'rg${environment}'
param location string = 'westeurope'

resource demoresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name:resourceGname
  location:location
  tags: {
    tagName1: 'testing'
    tagName2: 'v1.0'
  }
  managedBy: 'string'
  properties: {} 
}

