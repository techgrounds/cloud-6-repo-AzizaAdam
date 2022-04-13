param location string = 'westeurope'
param vnet1 string = 'vnetaapserver'
param vnet2 string = 'ventadminserver'
param ipv6Enabled bool = true
param subnetCount int = 64
param subnet1_name string = 'testvnet1'
param subnet2_name string = 'testvnet2'
param ddosProtectionPlanEnabled bool=  true 
param firewallEnabled bool = false
param bastionEnabled bool = true

resource virtualNetwork1 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet1
  location: location
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
        name: subnet1_name
        properties: {
          addressPrefix: '10.2.0.0/24'
        }
      }
    ]
    enableDdosProtection: null
  }
  dependsOn: []
}


// adding vnet2
resource virtualNetwork2 'Microsoft.Network/virtualNetworks@2021-05-01'= {
  name: vnet2
  location: location
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
        name: subnet2_name
        properties: {
          addressPrefix: '20.2.0.0/24'
        }
      }
    ]
  }
  dependsOn: []
}
