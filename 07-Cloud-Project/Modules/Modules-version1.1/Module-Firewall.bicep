param location string = resourceGroup().location
param FirewallName string = 'Firewall${uniqueString(environment)}'

param environment string = 'test'
param azureFirewallTier string = 'Premium'
param projectResourcegroupName string 
param zones array = []  
param subnetId string
param publicIpAddressName string = 'FirewallPubIP${uniqueString(environment)}'


resource Firewall_publicIpAddress 'Microsoft.Network/publicIpAddresses@2020-08-01' = {
  name: publicIpAddressName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource azureFirewall 'Microsoft.Network/azureFirewalls@2020-05-01' = {
  name: FirewallName
  location: location
  zones: zones
  properties: {
    ipConfigurations: [
      {
        name: publicIpAddressName
        properties: {
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: Firewall_publicIpAddress.id
          }
        }
      }
    ]
    sku: {
      tier: azureFirewallTier
      name: 'AZFW_VNet'
    }
    
    firewallPolicy: {
      id: resourceId(projectResourcegroupName, 'Microsoft.Network/firewallPolicies', FirewallPolicy.name)
    }
  }
  dependsOn: [
    Firewall_publicIpAddress    
  ]
}
  
param LogAnalyticsworkspaceId string
param managedId string 
// adding Firewall polcies
param FirewallPolicyName string = 'FirewallPolicy${uniqueString(environment)}'
resource FirewallPolicy 'Microsoft.Network/firewallPolicies@2021-05-01'={
 
  name: FirewallPolicyName
  location:location  
  
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities:{
      '${managedId}': {}
    }
  }
  properties: {
    dnsSettings: {
      enableProxy: true
      requireProxyForNetworkRules: true
      servers: [
        'webAppServer'
      ]
    }
    explicitProxySettings: {
      enableExplicitProxy: true
      httpPort: 80
      httpsPort: 443
      pacFile: 'string'
      pacFilePort: 8082
    }
    insights: {
      isEnabled: true
      logAnalyticsResources: {
        defaultWorkspaceId: {
          id: LogAnalyticsworkspaceId
        }
        workspaces: [
          {
            region: 'westeurope'
            workspaceId: LogAnalyticsworkspaceId
          }
        ]
      }
      retentionDays: 7
    }
    sku: {
      tier: 'Standard'
    }
    snat: {
      privateRanges: [
        'string'
      ]
    }
    sql: {
      allowSqlRedirect: true
    }
    threatIntelMode: 'Off'
    threatIntelWhitelist: {
      fqdns: [
        'microsoft.com'
      ]
      ipAddresses: [
        'string'
      ]
    }
  }
}
