param virtualMachineSize string
param adminUsername string

@secure()
param adminPassword string

param location string = resourceGroup().location
param virtualMachineName string
param nic1Id string
param nic2Id string
param diagsStorageUri string

resource vm 'Microsoft.Compute/virtualMachines@2017-03-30' = {
  name: 'demo-admin-vm'
  location: 'westeurope'
  properties: {
    osProfile: {
      computerName: virtualMachineName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: ["[parameters('virtualNetworks_demovnet2_externalid')]"
        {
          properties: {
            primary: true
          }
          id: nic1Id
        }
        {
          properties: {
            primary: false
          }
          id: nic2Id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: diagsStorageUri
      }
    }
  }
}
