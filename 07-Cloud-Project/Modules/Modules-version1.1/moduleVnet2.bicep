//validated bicep file
//vnet module
param location string = resourceGroup().location
param environment string = 'test'
param vnetadmin_name string = 'vnet_adminserver_${environment}'
param nsgAdmin_name string = 'admin_nsg_${environment}'
param pubipAdmin_name string = 'admin_ip_${environment}'
param nicAdmin_name string = 'admin_nic_${environment}'
param virtualNetworks_vmss_name string = 'vnet_vmss'
param publicIPAddresses_AGW_name string = 'appGwPip'


// virtual network AppGateway- Appserver (vmss)
resource virtualNetworks_vmss 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_vmss_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    enableDdosProtection: false
  }
}


param AGWsubnet_name string = 'appGWSubnet'
resource virtualNetworks_appGwSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vmss
  name: AGWsubnet_name
  properties: {
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup: {
      id: nsgAppgateway.id
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
}

param vmssSubnet_name string = 'vmssSubnet'

resource virtualNetworks_vmssSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vmss
  name: vmssSubnet_name
  properties: {
    addressPrefix: '10.0.2.0/24'
    natGateway: {
      id:natGateways.id
    }
    }
  }


// adding nic for the vmss webserver
param nicWebserver_name string = 'webserver_nic_${environment}'

resource nic_webserver 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: nicWebserver_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '10.0.2.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vmssSubnet.id
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

// adding public IP to the application gateway
resource publicIPAddresses_AGW 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_AGW_name
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// NSG webApp server inbound rules
param nsgwebSSH_rules_name string ='nsg_webrules_SHH_${environment}'

resource nsgwebApp_rules_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2021-05-01' = {
  parent: nsgAppgateway
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


param nsgAppGW_name string = 'AGW_nsg_${environment}'

// adding NSG for the appgateway vnet
resource nsgAppgateway 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: nsgAppGW_name
  location: location
  properties: {
    securityRules: [
      {
        name: 'https_in_nsgAppGW'
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
        name: 'http_in_nsgAppGW'
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
      {
        name: 'Port_AppGW'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '65200-65535'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 130
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Port_AppGWout'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '65200-65535'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 140
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Port_8080'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 150
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Port_443'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 160
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}
 // adding public IP for the NAT gateway for the vmss
 resource NATgateway_pubIp 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'NATip'
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

param NATgateway_name string = 'NATgateway-vmss'
// adding NAT gateway for the vmss 
resource natGateways 'Microsoft.Network/natGateways@2020-11-01' = {
  name: NATgateway_name
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    idleTimeoutInMinutes: 4
    publicIpAddresses: [
      {
        id: NATgateway_pubIp.id
      }
    ]
  }
}

param adminSubnet_name string = 'adminSubnet'
// adding vnetAdminServer
resource vnetAdmin 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: vnetadmin_name
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
  parent: vnetAdmin
  name: adminSubnet_name
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


resource nic_winadmin 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: nicAdmin_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '20.0.0.4'
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


output nicadminId string = nic_winadmin.id

output vnetAdminName string = vnetAdmin.name
output vnetAdminId string = vnetAdmin.id
output adminvnetname string = vnetAdmin.name
output vnetvmssId string = virtualNetworks_vmss.id
output vnetvmssname string = virtualNetworks_vmss.name
output adminpipId string =  pubipAdminserver.id
output adminPipname string =  pubipAdminserver.id
output AGWPipId string = publicIPAddresses_AGW.id
output AGWPipname string = publicIPAddresses_AGW.name
output NicAdminname string = nic_winadmin.name
output nicadminId_out string = nic_winadmin.id
output adminSubnetname string = AdminSubnet.name
output adminSubnetId string = AdminSubnet.id
output vmssSubnetname string = virtualNetworks_vmssSubnet.name
output vmssSubnetId string = virtualNetworks_vmssSubnet.id
output AGWSubnetname string = virtualNetworks_appGwSubnet.name
output AGWSubnetId string = virtualNetworks_appGwSubnet.id
