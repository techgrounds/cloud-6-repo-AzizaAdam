// the targetscope for this file
targetScope ='resourceGroup'
param location string = 'westeurope'



resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  name: 'virtualNetwork/name'   
  properties: {     
  allowVirtualNetworkAccess: true     
  allowForwardedTraffic: true     
  allowGatewayTransit: true     
  useRemoteGateways: true
  remoteVirtualNetwork: {
    id: 'virtualNetworks.id'
  }
}
}
