// peering module

param vnetAdminId string 
param vnetvmssId string
param vnetvmssname string 
param vnetAdminName string 

// adding existing vnets

resource adminvnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnetAdminName
}

resource webservervnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnetvmssname
}

// adding peering service to vnetvmss for the AppServer vmss
resource vnetwebApppeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: webservervnet
  name: '${vnetvmssname}-${vnetAdminName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vnetAdminId
    }
  }
}

// adding peering from vnetAdmin to vnet AppServer
resource vnetAdminPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: adminvnet
  name: '${vnetAdminName}-${vnetvmssname}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vnetvmssId
    }
  }
}
