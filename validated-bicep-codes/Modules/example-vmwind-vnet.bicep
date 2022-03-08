//Admin Windows server

@description('Default Admin username')
param adminUsername string

@description('Default Admin password')
@secure()
param adminPassword string

@description('Storage Account type for the VM and VM diagnostic storage')
@allowed([
  'Standard_LRS'
  'Premium_LRS'
])
param storageAccountType string = 'Standard_LRS'

@description('Location for all resources.')
param location string = resourceGroup().location

param environment string = 'test'

param vm_windowsadmin_name string = 'vmAdmin${environment}'

param vnet1 string = 'vnet_webserver_${environment}'

var virtualMachineName = 'adminserver'
var nic1Name = 'nic-1'
var nic2Name = 'nic-2'
var subnet1Name = 'subnet-1'
var subnet2Name = 'subnet-2'
var publicIPAddressName = 'publicIp'
var networkSecurityGroupName = 'NSG'
var networkSecurityGroupName2 = '${subnet2Name}-nsg'


// This is the virtual machine that you're building.
resource vmAdmin 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vm_windowsadmin_name
  location: location
  zones: [
    '2'
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
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachineName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
        }
      }
    secrets: []
      allowExtensionOperations: true

    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic1.id
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
    

// Simple Network Security Group for subnet2
resource nsg2 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: networkSecurityGroupName2
  location: location
}

// This will build a Virtual Network.
resource vnetAdmin 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnet1
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: nsg.id
            
          }
           }
            }
      {
        name: subnet2Name
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: nsg2.id
          }
        }
      }
    ]
  }
}

// This will be your Primary NIC
resource nic1 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: nic1Name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetAdmin.name, subnet1Name)
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
      
    }
  }
}

// This will be your Secondary NIC
resource nic2 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: nic2Name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetAdmin.name, subnet2Name)
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

// Public IP for your Primary NIC
resource pip 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// Network Security Group (NSG) for your Primary NIC
resource nsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          priority: 1000
          sourceAddressPrefix: '*'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}


// adding encryption module with storage account


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
            'unwrapKey'
            'wrapKey'
            'get'
            'list'
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
  }
}


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


// add encryptionkeysets

param encryptionkeysetsName string = 'encryptionketset${uniqueString(resourceGroup().name)}'
 

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
 