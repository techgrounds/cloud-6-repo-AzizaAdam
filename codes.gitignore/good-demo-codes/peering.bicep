param environmet string = 'test'
param location string = resourceGroup().location
param addressSpaces1 array
param addressSpaces2 array
param ipv6Enabled bool = true
param ddosProtectionPlanEnabled bool = false
param firewallEnabled bool = false
param bastionEnabled bool = true

resource myvnetpeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: 'peeringTest9'
  parent: resourceId(virtualNetwork,'vnet_app_server') virtualNetwork_resource1
  properties: {
    allowForwardedTraffic: bool
    allowGatewayTransit: bool
    allowVirtualNetworkAccess: bool
    doNotVerifyRemoteGateways: bool
    peeringState: 'string'
    peeringSyncLevel: 'string'
    remoteAddressSpace: {
      addressPrefixes: [
        'string'
      ]
    }
    remoteBgpCommunities: {
      virtualNetworkCommunity: 'string'
    }
    remoteVirtualNetwork: {
      id: 'string'
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        'string'
      ]
    }
    useRemoteGateways: bool
  }
}
