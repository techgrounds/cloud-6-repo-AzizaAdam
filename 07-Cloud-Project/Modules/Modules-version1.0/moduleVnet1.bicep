
//vnet module
param location string = resourceGroup().location
param environment string = 'test'
param vnet1 string = 'vnet_webserver_${environment}'
param vnet2 string = 'vnet_adminserver_${environment}'
param nsgAdmin_name string = 'admin_nsg_${environment}'
param nsgwebApp_name string = 'web_nsg_${environment}'
param nsgwebSSH_rules_name string ='nsg_webrules_SHH_${environment}'
param pubipAdmin_name string = 'admin_ip_${environment}'
param nicAdmin_name string = 'admin_nic_${environment}'
param pubipWebApp_name string = 'webserver_ip_${environment}'
param nicWebserver_name string = 'webserver_nic_${environment}'


// virtual network webApp server
resource vnetAppServer 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet1
  location: location
   tags: {
    project: 'vnet'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/24'
      ]
    }
    
    enableDdosProtection: null
  }
  dependsOn: []
}

// adding subnet for webappServer vnet1

resource webAppSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  name: '${vnet1}/webserv_subnet'
  properties: {
    addressPrefix: '10.0.0.0/26'
    networkSecurityGroup: {
      id: nsgwebApp.id
    }
    serviceEndpoints: [
      {
        service: 'Microsoft.KeyVault'
        locations: [
          '*'
        ]
      }
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    vnetAppServer
  ]
}
output nic_admin_out string = nic_winadmin.id
output nic_webserver_out string = nic_webserver.id

// adding peering service to vnet1 for the AppServer
resource vnetwebApppeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: vnetAppServer
  name: '${vnet1}-${vnet2}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vnetAdmin.id
    }
  }
  dependsOn: [
    webAppSubnet
    AdminSubnet
  ]
}

// adding NSG for the webApp Server vnet

resource nsgwebApp 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: nsgwebApp_name
  location: location
  properties: {
    securityRules: [
      {
        name: 'https_in_webnsg'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'http_in_webnsg'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

// NSG webApp server inbound rules
resource nsgwebApp_rules_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2021-05-01' = {
  parent: nsgwebApp
  name: nsgwebSSH_rules_name
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: nic_winadmin.properties.ipConfigurations[0].properties.privateIPAddress
    destinationAddressPrefix: nic_webserver.properties.ipConfigurations[0].properties.privateIPAddress
    access: 'Allow'
    priority: 150
    direction: 'Inbound'
  }
}

// adding vnetAdminServer
resource vnetAdmin 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: vnet2
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '20.0.0.0/24'
      ]
    }
    enableDdosProtection: false
  }
}

// adding subnet for vnet admin 
resource AdminSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  name: '${vnet2}/admin_subnet'
  properties: {
    addressPrefix: '20.0.0.0/28'
    networkSecurityGroup: {
      id: nsgAdmin.id
    }
    serviceEndpoints: [
      {
        service: 'Microsoft.KeyVault'
        locations: [
          '*'
        ]
      }
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    vnetAdmin
  ]
}

// adding peering from vnetAdmin to vnet AppServer
resource vnetAdminPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: vnetAdmin
  name: '${vnet2}-${vnet1}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vnetAppServer.id
    }
  }
  dependsOn: [
    AdminSubnet
    webAppSubnet
  ]
}

// nsgroups and rules follow:
resource nsgAdmin 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: nsgAdmin_name
  location: location
  properties: {
    securityRules: [
      {
        name: 'admin_trust'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: [
            '192.168.2.7'
          ]
        
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource pubipWebserver 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: pubipWebApp_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
  ]
  properties:{
    publicIPAllocationMethod:'Static'
  }
}

resource pubipAdminserver 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: pubipAdmin_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
  ]
  properties:{
    publicIPAllocationMethod:'Static'
  }
}

resource nic_webserver 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: nicWebserver_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '10.20.20.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pubipWebserver.id
          }
          subnet: {
            id: webAppSubnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}

resource nic_winadmin 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: nicAdmin_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '20.10.10.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pubipAdminserver.id
          }
          subnet: {
            id: AdminSubnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}


output nicwebserver_out string = nic_webserver.id
output nicadminId string = nic_winadmin.id
output vnetAdminId string = vnetAdmin.id
output adminvnetname string = vnetAdmin.name
output adminpipId string =  pubipAdminserver.id
output adminPipname string =  pubipAdminserver.id
output NicAdminname string = nic_winadmin.name
output adminSubnetname string = AdminSubnet.name
output adminSubnetId string = AdminSubnet.id
