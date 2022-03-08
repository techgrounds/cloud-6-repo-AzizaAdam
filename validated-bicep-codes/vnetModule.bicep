// vent1
param environmet string = 'test'
param vnet_app_server_name string = 'vnet_app_server_${environmet}'
param vnet_admin_server_name string = 'vnet_admin_server_${environmet}'
param location string = resourceGroup().location
param addressSpaces1 array
param addressSpaces2 array
param ipv6Enabled bool = true
param subnetCount int = 64
param ddosProtectionPlanEnabled bool = false
param firewallEnabled bool = false
param bastionEnabled bool = true



resource virtualNetwork_resource1 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet_app_server_name 

  location: location
   tags: {
    project: 'Sentiav1.0'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '30.2.0.0/16'
        '30.20.10.0/24'
      ]
    }
  }
}

resource subnet2012 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: '${'vnet_app_server_name'}${'subnet2012'}'
  properties:{
    addressPrefix:'30.2.0.0/24'
  }
  parent: virtualNetwork_resource1
}
// vnet2

resource virtualNetworkName_resource2 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet_admin_server_name
  location: location
    tags: {}
  properties: {
    addressSpace: {
      addressPrefixes: [
        '40.2.0.0/16'
        '40.20.20.0/24'
      ]
    }
  }
}
resource subnet2010 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: '${'vnet_admin_server_name'}${'subnet2010'}'
  properties:{
    addressPrefix:'40.2.0.0/24'
  }
  parent: virtualNetworkName_resource2
}


// network peering resource


// Net security groups rules

