
@secure()
param virtualMachines_name string = 'demo-admin-vm'
param diskEncryptionSets_encryptionset_project_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/demo1/providers/Microsoft.Compute/diskEncryptionSets/encryptionset-demo1'
param networkInterfaces_adminserver615_z2_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/demo1/providers/Microsoft.Network/networkInterfaces/adminserver615_z2'

resource virtualMachines_adminserver_name_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: 'demo-admin-vm'
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
        name: '${virtualMachines_adminserver_name}
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          diskEncryptionSet: {
            id: diskEncryptionSets_encryptionset_project_externalid
          }
          storageAccountType: 'Premium_LRS'
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
          id: networkInterfaces_adminserver615_z2_externalid
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://projectstorageaccount799.blob.core.windows.net/'
      }
    }
  }
}
