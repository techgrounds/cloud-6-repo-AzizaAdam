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
  name: 'demovnet1'
  location: 'westeurope'
   tags: {
    project: 'vnet'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
        '10.20.10.0/24'
      ]
    }
    subnets: [
      {
        name: 'demosubnet1'
        properties: {
          addressPrefix: '10.2.0.0/24'
        }
      }
    ]
    enableDdosProtection: null
  }
  dependsOn: []
}
