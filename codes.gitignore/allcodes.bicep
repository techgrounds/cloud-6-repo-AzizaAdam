param vaults_keyvault77909_name string = 'keyvault77909'
param virtualMachines_adminserver_name string = 'adminserver'
param virtualNetworks_vnet_subnet1_name string = 'vnet-subnet1'
param virtualNetworks_vnet_subnet2_name string = 'vnet-subnet2'
param virtualMachines_web_app_server7_name string = 'web-app-server7'
param privateEndpoints_web_app_server_name string = 'web-app-server'
param vaults_defaultVault650_name string = 'defaultVault650'
param publicIPAddresses_adminserver_ip_name string = 'adminserver-ip'
param sshPublicKeys_web_app_server7_key_name string = 'web-app-server7_key'
param networkInterfaces_adminserver615_z2_name string = 'adminserver615_z2'
param publicIPAddresses_web_app_server7_ip_name string = 'web-app-server7-ip'
param networkSecurityGroups_adminserver_nsg_name string = 'adminserver-nsg'
param networkInterfaces_web_app_server7973_z2_name string = 'web-app-server7973_z2'
param diskEncryptionSets_encryptionset_project_name string = 'encryptionset-project'
param storageAccounts_projectstorageaccount799_name string = 'projectstorageaccount799'
param networkSecurityGroups_web_app_server7_nsg_name string = 'web-app-server7-nsg'
param userAssignedIdentities_identity566_name string = 'identity566'
param vaults_RecoveryServiceVault_appServer_name string = 'RecoveryServiceVault-appServer'
param privateDnsZones_privatelink_blob_core_windows_net_name string = 'privatelink.blob.core.windows.net'
param networkInterfaces_web_app_server_nic_3075d517_3b72_4414_92cc_0b51f56cdfdd_name string = 'web-app-server.nic.3075d517-3b72-4414-92cc-0b51f56cdfdd'
param storageAccounts_projectstorageaccount7_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/project/providers/Microsoft.Storage/storageAccounts/projectstorageaccount7'

resource sshPublicKeys_web_app_server7_key_name_resource 'Microsoft.Compute/sshPublicKeys@2021-11-01' = {
  name: sshPublicKeys_web_app_server7_key_name
  location: 'westeurope'
  tags: {
    project: 'web-app-server'
  }
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCi8owcP7vRCW5vI5gjuhrgeiTz\r\nPtI7/vwGOcurOQVJGvrNnILObH4KwSKpRES5Qzdx376k+2u1igo7duB+h33tCA+p\r\n2qQF77qwj6j1MeRLJc2IQ8Hp35xRz2N2mn4nRAbgfAPu85Jr6KVnQ1d+Y/KkdRPL\r\nYFhmitMcxVEWt2JQujmA9zVhVG3bUjPfW3Yzh/NrcZvvX+fHft/XTSv8r0DBVQa1\r\nRpD+wh0TzZ2hRx4p5T/WsKO1suE3VRWr2EL8VQbmiVWlYDNcwrMi2LXU0lN825An\r\nAYmX7z0a7ATR5KPyPTPu9S1yxCo/cx5AUpwtjZVceqVaVL930bQCZbzN7GboX1Ow\r\nBiD7FeJiUSbZWAwYQt7W1ZWAVIwap/pocUQk67k+6/Q0XUqcf1NQNKiVJTk+7pq9\r\np/8qBuRz1jOTm1xWEDw9+IFD7YxWljP/BjHXE/lFh4h7ih7HuaAtoO8PvlKpnw2Y\r\nGGrMBrNFCJCXQ6UL5+KREi68U4IZYN/OTTTw6sU= generated-by-azure\r\n'
  }
}

resource userAssignedIdentities_identity566_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: userAssignedIdentities_identity566_name
  location: 'westeurope'
}

resource networkSecurityGroups_adminserver_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_adminserver_nsg_name
  location: 'westeurope'
  tags: {
    project: 'adminserver'
  }
  properties: {
    securityRules: [
      {
        name: 'RDP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
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

resource networkSecurityGroups_web_app_server7_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_web_app_server7_nsg_name
  location: 'westeurope'
  tags: {
    project: 'web-app-server'
  }
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'HTTP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 320
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

resource privateDnsZones_privatelink_blob_core_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDnsZones_privatelink_blob_core_windows_net_name
  location: 'global'
  properties: {
    maxNumberOfRecordSets: 25000
    maxNumberOfVirtualNetworkLinks: 1000
    maxNumberOfVirtualNetworkLinksWithRegistration: 100
    numberOfRecordSets: 2
    numberOfVirtualNetworkLinks: 1
    numberOfVirtualNetworkLinksWithRegistration: 0
    provisioningState: 'Succeeded'
  }
}

resource publicIPAddresses_adminserver_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_adminserver_ip_name
  location: 'westeurope'
  tags: {
    project: 'adminserver'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '2'
  ]
  properties: {
    ipAddress: '20.56.178.249'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_web_app_server7_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_web_app_server7_ip_name
  location: 'westeurope'
  tags: {
    project: 'web-app-server'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '2'
  ]
  properties: {
    ipAddress: '52.142.226.251'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource vaults_defaultVault650_name_resource 'Microsoft.RecoveryServices/vaults@2021-11-01-preview' = {
  name: vaults_defaultVault650_name
  location: 'westeurope'
  tags: {
    project: 'web-app-server'
  }
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource vaults_RecoveryServiceVault_appServer_name_resource 'Microsoft.RecoveryServices/vaults@2021-11-01-preview' = {
  name: vaults_RecoveryServiceVault_appServer_name
  location: 'westeurope'
  tags: {
    project: 'web-appServer'
  }
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource diskEncryptionSets_encryptionset_project_name_resource 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: diskEncryptionSets_encryptionset_project_name
  location: 'westeurope'
  tags: {
    project: 'encryptionSet'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    activeKey: {
      sourceVault: {
        id: vaults_keyvault77909_name_resource.id
      }
      keyUrl: 'https://keyvault77909.vault.azure.net/keys/encryptionDisckey/ca3e86a4045f436dbbf76749d2c85ac9'
    }
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: true
  }
}

resource virtualMachines_web_app_server7_name_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: virtualMachines_web_app_server7_name
  location: 'westeurope'
  tags: {
    project: 'web-app-server'
  }
  zones: [
    '2'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_web_app_server7_name}_OsDisk_1_3b1b4e5a43ac4ce2a503b07082a803eb'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_web_app_server7_name}_OsDisk_1_3b1b4e5a43ac4ce2a503b07082a803eb')
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_web_app_server7_name
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCi8owcP7vRCW5vI5gjuhrgeiTz\r\nPtI7/vwGOcurOQVJGvrNnILObH4KwSKpRES5Qzdx376k+2u1igo7duB+h33tCA+p\r\n2qQF77qwj6j1MeRLJc2IQ8Hp35xRz2N2mn4nRAbgfAPu85Jr6KVnQ1d+Y/KkdRPL\r\nYFhmitMcxVEWt2JQujmA9zVhVG3bUjPfW3Yzh/NrcZvvX+fHft/XTSv8r0DBVQa1\r\nRpD+wh0TzZ2hRx4p5T/WsKO1suE3VRWr2EL8VQbmiVWlYDNcwrMi2LXU0lN825An\r\nAYmX7z0a7ATR5KPyPTPu9S1yxCo/cx5AUpwtjZVceqVaVL930bQCZbzN7GboX1Ow\r\nBiD7FeJiUSbZWAwYQt7W1ZWAVIwap/pocUQk67k+6/Q0XUqcf1NQNKiVJTk+7pq9\r\np/8qBuRz1jOTm1xWEDw9+IFD7YxWljP/BjHXE/lFh4h7ih7HuaAtoO8PvlKpnw2Y\r\nGGrMBrNFCJCXQ6UL5+KREi68U4IZYN/OTTTw6sU= generated-by-azure\r\n'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_web_app_server7973_z2_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource vaults_keyvault77909_name_encryptionDisckey 'Microsoft.KeyVault/vaults/keys@2021-11-01-preview' = {
  parent: vaults_keyvault77909_name_resource
  name: 'encryptionDisckey'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource networkInterfaces_web_app_server_nic_3075d517_3b72_4414_92cc_0b51f56cdfdd_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_web_app_server_nic_3075d517_3b72_4414_92cc_0b51f56cdfdd_name
  location: 'westeurope'
  tags: {
    project: 'stg'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'privateEndpointIpConfig.55755e65-cdcf-42da-b636-fbd7478e064c'
        properties: {
          privateIPAddress: '10.1.0.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_subnet1_name_default.id
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

resource networkSecurityGroups_web_app_server7_nsg_name_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_web_app_server7_nsg_name_resource
  name: 'HTTP'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 320
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_adminserver_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_adminserver_nsg_name_resource
  name: 'RDP'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_web_app_server7_nsg_name_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_web_app_server7_nsg_name_resource
  name: 'SSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_projectstorageaccount7 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'projectstorageaccount7'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.1.0.4'
      }
    ]
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_blob_core_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2018-09-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource privateEndpoints_web_app_server_name_resource 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: privateEndpoints_web_app_server_name
  location: 'westeurope'
  tags: {
    project: 'stg'
  }
  properties: {
    privateLinkServiceConnections: [
      {
        name: '${privateEndpoints_web_app_server_name}_21c7720f-6688-41f4-bc39-217fb8ec8011'
        properties: {
          privateLinkServiceId: storageAccounts_projectstorageaccount7_externalid
          groupIds: [
            'blob'
          ]
          privateLinkServiceConnectionState: {
            status: 'Disconnected'
            description: 'storage account being deleted'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    subnet: {
      id: virtualNetworks_vnet_subnet1_name_default.id
    }
    customDnsConfigs: []
  }
}

resource virtualNetworks_vnet_subnet1_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_vnet_subnet1_name
  location: 'westeurope'
  tags: {
    project: 'vnet'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
        '10.10.10.0/24'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.1.0.0/24'
          serviceEndpoints: [
            {
              service: 'Microsoft.KeyVault'
              locations: [
                '*'
              ]
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'project-peering'
        properties: {
          peeringState: 'Connected'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_subnet2_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
              '10.20.20.0/24'
            ]
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_subnet2_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_vnet_subnet2_name
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
        '10.20.20.0/24'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.2.0.0/24'
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
    ]
    virtualNetworkPeerings: [
      {
        name: 'project-peering-link'
        properties: {
          peeringState: 'Connected'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_subnet1_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
              '10.10.10.0/24'
            ]
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_subnet1_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  name: '${virtualNetworks_vnet_subnet1_name}/default'
  properties: {
    addressPrefix: '10.1.0.0/24'
    serviceEndpoints: [
      {
        service: 'Microsoft.KeyVault'
        locations: [
          '*'
        ]
      }
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_subnet1_name_resource
  ]
}

resource virtualNetworks_vnet_subnet2_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  name: '${virtualNetworks_vnet_subnet2_name}/default'
  properties: {
    addressPrefix: '10.2.0.0/24'
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
    virtualNetworks_vnet_subnet2_name_resource
  ]
}

resource vaults_defaultVault650_name_BackupPlan_project 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_defaultVault650_name_resource
  name: 'BackupPlan-project'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2022-02-17T02:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2022-02-17T02:00:00Z'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'W. Europe Standard Time'
    protectedItemsCount: 0
  }
}

resource vaults_RecoveryServiceVault_appServer_name_Daillybackupappserver 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_RecoveryServiceVault_appServer_name_resource
  name: 'Daillybackupappserver'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2022-02-18T01:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2022-02-18T01:00:00Z'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'W. Europe Standard Time'
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault650_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_defaultVault650_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2022-02-17T20:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2022-02-17T20:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_RecoveryServiceVault_appServer_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_RecoveryServiceVault_appServer_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2022-02-18T00:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2022-02-18T00:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_RecoveryServiceVault_appServer_name_DiallyBackup_aapServerPlan 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_RecoveryServiceVault_appServer_name_resource
  name: 'DiallyBackup-aapServerPlan'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {
      azureBackupRGNamePrefix: 'project'
      azureBackupRGNameSuffix: 'appServer'
    }
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2022-02-17T02:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2022-02-17T02:00:00Z'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'W. Europe Standard Time'
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault650_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_defaultVault650_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2022-02-17T20:00:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2022-02-17T20:00:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_RecoveryServiceVault_appServer_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_RecoveryServiceVault_appServer_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2022-02-18T00:00:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2022-02-18T00:00:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault650_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2021-08-01' = {
  parent: vaults_defaultVault650_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_RecoveryServiceVault_appServer_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2021-08-01' = {
  parent: vaults_RecoveryServiceVault_appServer_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_defaultVault650_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2021-08-01' = {
  parent: vaults_defaultVault650_name_resource
  name: 'default'
  properties: {}
}

resource vaults_RecoveryServiceVault_appServer_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2021-08-01' = {
  parent: vaults_RecoveryServiceVault_appServer_name_resource
  name: 'default'
  properties: {}
}

resource storageAccounts_projectstorageaccount799_name_resource 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccounts_projectstorageaccount799_name
  location: 'westeurope'
  tags: {
    project: 'st'
  }
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/project/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity566': {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        identityUrl: 'https://control-westeurope.identity.azure.net/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourcegroups/project/providers/Microsoft.Storage/storageAccounts/projectstorageaccount799/credentials/v2/userassigned?arpid=e1b4a33e-a82d-4d6d-9b82-2d23564542e6&uaid=69fde7b4-a3f9-48b7-bdd6-af82d30d75ce&tid=de60b253-74bd-4365-b598-b9e55a2b208d'
        certRenewAfter: '2022-04-05T12:19:00Z'
      }
    }
  }
  properties: {
    defaultToOAuthAuthentication: false
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      identity: {
        userAssignedIdentity: userAssignedIdentities_identity566_name_resource.id
      }
      requireInfrastructureEncryption: false
      keyvaultproperties: {
        keyvaulturi: 'https://keyvault77909.vault.azure.net'
        keyname: 'encryptionDisckey'
      }
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        table: {
          keyType: 'Account'
          enabled: true
        }
        queue: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Keyvault'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_projectstorageaccount799_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  parent: storageAccounts_projectstorageaccount799_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: true
    changeFeed: {
      retentionInDays: 7
      enabled: true
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_projectstorageaccount799_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-08-01' = {
  parent: storageAccounts_projectstorageaccount799_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_projectstorageaccount799_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-08-01' = {
  parent: storageAccounts_projectstorageaccount799_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_projectstorageaccount799_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-08-01' = {
  parent: storageAccounts_projectstorageaccount799_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource vaults_keyvault77909_name_resource 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: vaults_keyvault77909_name
  location: 'westeurope'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      virtualNetworkRules: [
        {
          id: virtualNetworks_vnet_subnet1_name_default.id
          ignoreMissingVnetServiceEndpoint: false
        }
        {
          id: virtualNetworks_vnet_subnet2_name_default.id
          ignoreMissingVnetServiceEndpoint: false
        }
      ]
    }
    accessPolicies: [
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: '2ac95fd8-9277-4adb-80c8-af41d0c73dad'
        permissions: {
          keys: [
            'get'
            'list'
            'unwrapKey'
            'wrapKey'
          ]
          secrets: []
          certificates: []
        }
      }
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: '0c9e9953-88ce-4c99-ab40-441e61a26060'
        permissions: {
          keys: [
            'get'
            'list'
            'update'
            'create'
            'import'
            'delete'
            'recover'
            'backup'
            'restore'
            'decrypt'
            'encrypt'
            'unwrapKey'
            'wrapKey'
            'verify'
            'sign'
            'purge'
            'rotate'
            'getrotationpolicy'
            'setrotationpolicy'
          ]
          secrets: [
            'get'
            'list'
            'set'
            'delete'
            'recover'
            'backup'
            'restore'
            'purge'
          ]
          certificates: [
            'get'
            'list'
            'update'
            'create'
            'import'
            'delete'
            'recover'
            'backup'
            'restore'
            'managecontacts'
            'manageissuers'
            'getissuers'
            'listissuers'
            'setissuers'
            'deleteissuers'
            'purge'
          ]
        }
      }
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: 'ee09dadb-e944-4392-a486-562c4d7732c7'
        permissions: {
          keys: [
            'get'
            'list'
            'update'
            'create'
            'import'
            'delete'
            'recover'
            'backup'
            'restore'
            'decrypt'
            'encrypt'
            'unwrapKey'
            'wrapKey'
            'verify'
            'sign'
            'purge'
            'rotate'
            'getrotationpolicy'
            'setrotationpolicy'
          ]
          secrets: [
            'get'
            'list'
            'set'
            'delete'
            'recover'
            'backup'
            'restore'
            'purge'
          ]
          certificates: [
            'get'
            'list'
            'update'
            'create'
            'import'
            'delete'
            'recover'
            'backup'
            'restore'
            'managecontacts'
            'manageissuers'
            'getissuers'
            'listissuers'
            'setissuers'
            'deleteissuers'
            'purge'
          ]
        }
      }
    ]
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: false
    enablePurgeProtection: true
    vaultUri: 'https://${vaults_keyvault77909_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_fasysdh5efyos 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'fasysdh5efyos'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworks_vnet_subnet1_name_resource.id
    }
  }
}

resource virtualNetworks_vnet_subnet1_name_project_peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
  name: '${virtualNetworks_vnet_subnet1_name}/project-peering'
  properties: {
    peeringState: 'Connected'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_subnet2_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
        '10.20.20.0/24'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_subnet1_name_resource
  ]
}

resource virtualNetworks_vnet_subnet2_name_project_peering_link 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
  name: '${virtualNetworks_vnet_subnet2_name}/project-peering-link'
  properties: {
    peeringState: 'Connected'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_subnet1_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
        '10.10.10.0/24'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_subnet2_name_resource
  ]
}

resource storageAccounts_projectstorageaccount799_name_default_bootdiagnostics_adminserv_154bbc7e_fd70_493d_a76c_a72598a5d213 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' = {
  parent: storageAccounts_projectstorageaccount799_name_default
  name: 'bootdiagnostics-adminserv-154bbc7e-fd70-493d-a76c-a72598a5d213'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_projectstorageaccount799_name_resource
  ]
}

resource virtualMachines_adminserver_name_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: virtualMachines_adminserver_name
  location: 'westeurope'
  tags: {
    project: 'adminserver'
  }
  zones: [
    '2'
  ]
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_adminserver_name}_OsDisk_1_ebe6642378ee4466882a001aa8293e10'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          diskEncryptionSet: {
            id: diskEncryptionSets_encryptionset_project_name_resource.id
          }
          storageAccountType: 'Premium_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_adminserver_name}_OsDisk_1_ebe6642378ee4466882a001aa8293e10')
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_adminserver_name
      adminUsername: 'aziza'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_adminserver615_z2_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://${storageAccounts_projectstorageaccount799_name}.blob.core.windows.net/'
      }
    }
  }
  dependsOn: [
    storageAccounts_projectstorageaccount799_name_resource
  ]
}

resource networkInterfaces_adminserver615_z2_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_adminserver615_z2_name
  location: 'westeurope'
  tags: {
    project: 'adminserver'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '10.2.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_adminserver_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_subnet2_name_default.id
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
    networkSecurityGroup: {
      id: networkSecurityGroups_adminserver_nsg_name_resource.id
    }
  }
}

resource networkInterfaces_web_app_server7973_z2_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_web_app_server7973_z2_name
  location: 'westeurope'
  tags: {
    project: 'web-app-server'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '10.1.0.5'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_web_app_server7_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_subnet1_name_default.id
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
    networkSecurityGroup: {
      id: networkSecurityGroups_web_app_server7_nsg_name_resource.id
    }
  }
}