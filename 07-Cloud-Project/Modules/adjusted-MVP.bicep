//VMs, Vnets, storageaccount, blob, conatainer, keyvault, managedID,encryptionsets
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

// params diskencryptionset
param encryptionkeysetsName string = 'encryptionketset${uniqueString(resourceGroup().name)}'

// params accesspolicies to keyvault
param policyoperation string = 'add'

// params storage account, blobstroage, container, keyvault, managedId

@description('The Tenant Id that should be used throughout the deployment.')
param tenantId string = subscription().tenantId

@description('The name of the User Assigned Identity.')
param userAssignedIdentityName string= 'userid${uniqueString(resourceGroup().name)}' 

@description('The name of the Key Vault.')
param keyVaultName string = 'keyVault${uniqueString(resourceGroup().name)}' 

@description('Name of the key in the Key Vault')
param keyVaultKeyName string = 'key${uniqueString(resourceGroup().name)}' 

@description('The name of the Storage Account')
param storageAccountName string = 'stg${uniqueString(resourceGroup().id)}' 
param containerName string = 'cont${uniqueString(resourceGroup().id)}'


// params VMs (webApp server Linux, Admin server Windows0
@description('Username for the Virtual Machine.')
param adminUsername string

@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsLabelPrefix string = toLower('simplelinuxvm-${uniqueString(resourceGroup().id)}')

param diskencryptId string = encryptionkeysetsName
param vm_linwebserver_name string = 'webserver'
param vm_windowsadmin_name string = 'adminserver'

// Sample key data, please adjust the urls to point to a new location or simply provide the data as a string.
param pubkey string = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVvmAMi/zZWzXzEZEabevnUvL/PNEbqD42T5yfpsnN4c8EtBTjLMlyNffxGMsndbrpc5pr0aGP2GHfpT9F9uzqovFcswYnTrtieWXSnghuLynGICs9A6CACz0+M2lGvJ9Lnde9GZpjeIMe2AaOR4/jVYwdcu99Q6kkZx0I/tJzHXX7xMWAP2gFevYg7njQbTEyOGuTODfLwsC0oRNl+rE6xumWNiEvc+QuW75VboZwAepfboZtgwpCvsF2P+b0d1zKD0kP1YlISnCJw9GTuw1AZcQo7AFIsWb9K2YT2OWjcyJY+EVkIMds8npmOp0idkwfGh7XWVcFVSRxbf+K3LwrfseqmJdzUm+CNUNuySRP8a+1i6F9nvWzDV7moPU699xWlAEKgYfzmr3HbL3kSHQGtE5/ao7OvNCL4hpFP+DBu6YS8EY0JbCCJkrjNe72gmp3y5DtsE2DYDNX+Ys4v+ylOgIwmhvK3Rm952x1qXno2ABn5NB/uG+GAetoeYmZ45f4iTqaFPtK94xguqogNQVmxs46fn9DwjIUzK39DAnUA9dLP5ABYYbQDhFlLqulASYz0l0PxvS3J29J+GVNAr++JSTGmh0nC7tmDEL73wKcVAHilAAiHcI/p3k7r26zzDc08i/u/CjWfY1YdknCqxl6r7X74h5zZGu+fV4mMIKZxQ== zizan@LAPTOP-0KOJ4O3B'

param passadmin string = 'zizamyname@1982'

var script64 = loadFileAsBase64('./bootstrapscript.sh') 


// params for protected item, container for the recovery-vault and backup services
param recoveryvault_name string = 'recovault-${environment}'
param dailybackup_policy string = 'dailypolicy-${environment}'
param adminProtect string = 'vm;iaasvmcontainerv2;${resourceGroup().name};${vm_windowsadmin_name}'
param webProtect string = 'vm;iaasvmcontainerv2;${resourceGroup().name};${vm_linwebserver_name}'
param webcontainer string = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${vm_linwebserver_name}'
param admincontainer string = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${vm_windowsadmin_name}'
param fabricName string = 'Azurex'


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
output nicadmin_out string = nic_winadmin.id
output nicwebserver_out string = nic_webserver.id

// webApp server = Linux VM
// Admin management server = Windows VM
resource vmLinuxwebserver 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vm_linwebserver_name
  location: location
  zones: [
    '1'
  ]
  properties: {
    userData: script64
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-impish'
        sku: '21_10-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          diskEncryptionSet: {
            id: diskEncryptionSets.id
          }
          storageAccountType: 'StandardSSD_LRS'
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
    }
    osProfile: {
      computerName: vm_linwebserver_name
      adminUsername: '${vm_linwebserver_name}'
      adminPassword: null
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              keyData: pubkey
              path: '/home/${vm_linwebserver_name}/.ssh/authorized_keys'
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

    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic_webserver.id
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

resource vmAdmin_windows 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vm_windowsadmin_name
  location: location
  zones: [
    '1'
  ]
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
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          diskEncryptionSet: {
            id: diskEncryptionSets.id
          }
          storageAccountType: 'StandardSSD_LRS'
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
    }
    osProfile: {
      computerName: vm_windowsadmin_name
      adminUsername: '${vm_windowsadmin_name}user'
      adminPassword: passadmin
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

    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic_winadmin.id
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
output vmWebApp_ID_out string = vmLinuxwebserver.id
output vm_web_NAME_out string = vmLinuxwebserver.name

output vm_admin_ID_out string = vmAdmin_windows.id
output vm_admin_NAME_out string = vmAdmin_windows.name

output adminUsername string = adminUsername



//adding storage account and encryption resourses


resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: userAssignedIdentityName
  location: location
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    enableSoftDelete: true
    enablePurgeProtection: true
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        permissions: {
          keys: [
            'backup'
            'create'
            'decrypt'
            'delete'
            'encrypt'
            'get'
            'getrotationpolicy'
            'import'
            'list'
            'purge'
            'recover'
            'release'
            'restore'
            'rotate'
            'setrotationpolicy'
            'sign'
            'unwrapKey'
            'update'
            'verify'
            'wrapKey'
          ]
        }
        objectId: userAssignedIdentity.properties.principalId
      }
    ]
  }
}

resource kvKey 'Microsoft.KeyVault/vaults/keys@2021-06-01-preview' = {
  parent: keyVault
  name: keyVaultKeyName
  properties: {
    attributes: {
      enabled: true
    }
    keySize: 4096
    kty: 'RSA'
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'unwrapKey'
      'verify'
      'wrapKey'
    ]
  }
}

// add accesspolies to keyvault

resource accesspolcies 'Microsoft.KeyVault/vaults/accessPolicies@2021-10-01' = {
  name: policyoperation
  parent: keyVault
  properties: {
    accessPolicies:[
      {
        tenantId: tenantId
        objectId: diskEncryptionSets.identity.principalId
        permissions: {
          keys: [
            'get'
            'wrapKey'
            'unwrapKey'
            'encrypt'
            'decrypt'
          ]
          secrets: []
          certificates: []
        }
        
      }
      {
        tenantId: tenantId
        objectId: userAssignedIdentity.properties.principalId
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
    ]
  }
}

output diskencrypt_ID_out string = diskEncryptionSets.id
output kvurl_out string =  keyVault.properties.vaultUri

// add storageaccount with custom managed encryption

resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentity.id}': {}
    }
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    encryption: {
      identity: {
        userAssignedIdentity: userAssignedIdentity.id
      }
      services: {
         blob: {
           enabled: true
         }
      }
      keySource: 'Microsoft.Keyvault'
      keyvaultproperties: {
        keyname: kvKey.name
        keyvaulturi: endsWith(keyVault.properties.vaultUri,'/') ? substring(keyVault.properties.vaultUri,0,length(keyVault.properties.vaultUri)-1) : keyVault.properties.vaultUri
      }
    }
  }
}

//add blob storage

resource store_blob 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: storage
  name: 'default'
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }

    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}

// adding container 

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' = {
  name: containerName
  parent: store_blob
  properties: {
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    immutableStorageWithVersioning: {
      enabled: false
    }
    publicAccess: 'None'
  }
}


// add encryptionkeysets

 

resource diskEncryptionSets 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: encryptionkeysetsName
  location: location
  tags: {
    project: 'encryptionSet'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties:{
    activeKey:{
      sourceVault:{
        id: keyVault.id
      }
      keyUrl: kvKey.properties.keyUriWithVersion
    }
  }
}
output diskencryptset_IDout string = diskencryptId

// adding backup and recovery vault service and backup policies

resource recoveryvault 'Microsoft.RecoveryServices/vaults@2021-11-01-preview' = {
  name: recoveryvault_name
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource recovaultpolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-12-01' = {
  parent: recoveryvault
  name: dailybackup_policy
  properties: {
    backupManagementType: 'AzureIaasVM'
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2022-03-22T23:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2022-03-22T23:00:00Z'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'W. Europe Standard Time'
  }
}


// adding protected container and protected item for the recovervault service for both webApp server and admin server


resource webprotection 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-12-01' = {
  name: '${recoveryvault_name}/${fabricName}/${webcontainer}/${webProtect}'
  properties: {
    protectedItemType: 'Microsoft.ClassicCompute/virtualMachines'
    policyId: recovaultpolicy.id
    sourceResourceId: vmLinuxwebserver.id
  }
}

resource adminprotection 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-12-01' = {
  name: '${recoveryvault_name}/${fabricName}/${admincontainer}/${adminProtect}'
  properties: {
    protectedItemType: 'Microsoft.ClassicCompute/virtualMachines'
    policyId: recovaultpolicy.id
    sourceResourceId: vmAdmin_windows.id
  }
}

output vmAdmin_windowsId string = vmAdmin_windows.id
output vmAdmin_windowsName string = vmAdmin_windows.name

