param location string
param virtualNetworkName string
param resourceGroup string
param addressSpaces array
param ipv6Enabled bool
param subnetCount int
param subnet0_name string
param ddosProtectionPlanEnabled bool
param firewallEnabled bool
param bastionEnabled bool

resource virtualNetworkName_resource 'Microsoft.Network/VirtualNetworks@2021-01-01' = {
  name: 'demovnet2'
  location: 'westeurope'
    tags: {}
  properties: {
    addressSpace: {
      addressPrefixes: [
        '20.2.0.0/16'
        '20.20.20.0/24'
      ]
    }
    subnets: [
      {
        name: 'demosubnet2'
        properties: {
          addressPrefix: '20.2.0.0/24'
        }
      }
    ]
  }
  dependsOn: []
}
