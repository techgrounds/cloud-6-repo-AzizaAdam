targetScope = 'subscription'
param stage string = 'Testing'
param location string = deployment().location

param resourceGroup string = 'resourceGroup-${stage}'

resource resourceGrouptest 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroup
  location: location
}

module vnet1 'vnet1.bicep' = {
  scope: resourceGroup
  name: 'vnet1'
  params: {
    addressSpaces: 
    bastionEnabled: 
    ddosProtectionPlanEnabled: 
    firewallEnabled: 
    ipv6Enabled: 
    location: 
    resourceGroup: 
    subnet0_name: 
    subnetCount: 
    virtualNetworkName: 
  }
}
  name:'demovnet1'
  scope: resourceGrouptest
  params: {
    location: Location 
  }
  
module vnet2.'vnet2.bicep' = {
    name:'demovnet2'
    scope: resourceGrouptest
    params: {
      location: Location 
    }

module
