// webApp server = Linux VM
// Admin management server = Windows VM

@description('The location into which the resources should be deployed.')
param location string = resourceGroup().location

param environment string = 'test'
param diskencryptId string 
param nic_id_admin string
param nic_id_webserver string

param vnet1 string = 'vnet_webserver_${environment}'
param vnet2 string = 'vnet_adminserver_${environment}'
param nsgAdmin_name string = 'admin_nsg_${environment}'
param nsgwebApp_name string = 'web_nsg_${environment}'
param nsgwebSSH_rules_name string ='nsg_webrules_SHH_${environment}'
param pubipAdmin_name string = 'admin_ip_${environment}'
param nicAdmin_name string = 'admin_nic_${environment}'
param pubipWebApp_name string = 'webserver_ip_${environment}'
param nicWebserver_name string = 'webserver_nic_${environment}'


param vm_linwebserver_name string = 'vmWebApp-${environment}'
param vm_windowsadmin_name string = 'vmAdmin${environment}'

// Sample key data, please adjust the urls to point to a new location or simply provide the data as a string.
param pubkey string
param passadmin string 

var script64 = loadFileAsBase64('../bootstrapscript.sh') 

resource vmLinuxwebserver 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vm_linwebserver_name
  location: location
  zones: [
    '2'
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
            id: diskencryptId
          }
          storageAccountType: 'StandardSSD_LRS'
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
    }
    osProfile: {
      computerName: vm_linwebserver_name
      adminUsername: '${vm_linwebserver_name}user'
      adminPassword: null
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              keyData: pubkey
              path: '/home/${vm_linwebserver_name}user/.ssh/authorized_keys'
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
          id: nic_id_webserver
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
            id: diskencryptId
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
          id: nic_id_admin
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
