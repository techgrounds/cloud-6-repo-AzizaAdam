@secure()
param location string 
param extensions_Microsoft_Insights_VMDiagnosticsSettings_xmlCfg string

@secure()
param extensions_Microsoft_Insights_VMDiagnosticsSettings_storageAccountName string

@secure()
param environment string 
param versiontag object
param extensions_Microsoft_Insights_VMDiagnosticsSettings_storageAccountKey string
param diskencrypsetname string = 'encrypset${environment}'
@secure()
param extensions_Microsoft_Insights_VMDiagnosticsSettings_storageAccountEndPoint string
param virtualMachines_adminserver_name string = 'adminserver'
param diskEncryptionSets_encryptionset_project_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/TEST4/providers/Microsoft.Compute/diskEncryptionSets/encryptionset-project'
param disks_adminserver_OsDisk_1_ebe6642378ee4466882a001aa8293e10_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/project/providers/Microsoft.Compute/disks/adminserver_OsDisk_1_ebe6642378ee4466882a001aa8293e10'
param networkInterfaces_adminserver615_z2_externalid string = '/subscriptions/88ad0edb-f4f4-4dda-8d16-c6d5c372bef3/resourceGroups/project/providers/Microsoft.Network/networkInterfaces/adminserver615_z2'
param adminUsername string




resource virtualMachines_adminserver_name_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: virtualMachines_adminserver_name
  location: location
  tags: versiontag
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
            id: diskencrypsetname
          }
          storageAccountType: 'Premium_LRS'
          id: disks_adminserver_OsDisk_1_ebe6642378ee4466882a001aa8293e10_externalid
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_adminserver_name
      adminUsername: adminUsername
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

resource virtualMachines_adminserver_name_Microsoft_Insights_VMDiagnosticsSettings 'Microsoft.Compute/virtualMachines/extensions@2021-11-01' = {
  parent: virtualMachines_adminserver_name_resource
  name: 'Microsoft.Insights.VMDiagnosticsSettings'
  location: location 
  tags: {
    project: 'adminserver'
  }
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Azure.Diagnostics'
    type: 'IaaSDiagnostics'
    typeHandlerVersion: '1.5'
    settings: {
      StorageAccount: 'projectstorageaccount799'
      xmlCfg: extensions_Microsoft_Insights_VMDiagnosticsSettings_xmlCfg
    }
    protectedSettings: {
      storageAccountName: extensions_Microsoft_Insights_VMDiagnosticsSettings_storageAccountName
      storageAccountKey: extensions_Microsoft_Insights_VMDiagnosticsSettings_storageAccountKey
      storageAccountEndPoint: extensions_Microsoft_Insights_VMDiagnosticsSettings_storageAccountEndPoint
    }
  }
}
