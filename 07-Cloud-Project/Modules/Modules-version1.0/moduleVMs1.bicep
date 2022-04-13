//VMs, Vnets, storageaccount, blob, conatainer, keyvault, managedID,encryptionsets
//vnet module
param location string = resourceGroup().location

// params storage account, blobstroage, container, keyvault, managedId


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

param diskencryptId string 
param vm_linwebserver_name string = 'webserver'
param vm_windowsadmin_name string = 'adminserver'

// Sample key data, please adjust the urls to point to a new location or simply provide the data as a string.
param pubkey string = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVvmAMi/zZWzXzEZEabevnUvL/PNEbqD42T5yfpsnN4c8EtBTjLMlyNffxGMsndbrpc5pr0aGP2GHfpT9F9uzqovFcswYnTrtieWXSnghuLynGICs9A6CACz0+M2lGvJ9Lnde9GZpjeIMe2AaOR4/jVYwdcu99Q6kkZx0I/tJzHXX7xMWAP2gFevYg7njQbTEyOGuTODfLwsC0oRNl+rE6xumWNiEvc+QuW75VboZwAepfboZtgwpCvsF2P+b0d1zKD0kP1YlISnCJw9GTuw1AZcQo7AFIsWb9K2YT2OWjcyJY+EVkIMds8npmOp0idkwfGh7XWVcFVSRxbf+K3LwrfseqmJdzUm+CNUNuySRP8a+1i6F9nvWzDV7moPU699xWlAEKgYfzmr3HbL3kSHQGtE5/ao7OvNCL4hpFP+DBu6YS8EY0JbCCJkrjNe72gmp3y5DtsE2DYDNX+Ys4v+ylOgIwmhvK3Rm952x1qXno2ABn5NB/uG+GAetoeYmZ45f4iTqaFPtK94xguqogNQVmxs46fn9DwjIUzK39DAnUA9dLP5ABYYbQDhFlLqulASYz0l0PxvS3J29J+GVNAr++JSTGmh0nC7tmDEL73wKcVAHilAAiHcI/p3k7r26zzDc08i/u/CjWfY1YdknCqxl6r7X74h5zZGu+fV4mMIKZxQ== zizan@LAPTOP-0KOJ4O3B'

param passadmin string = 'zizamyname@1982'

var script64 = loadFileAsBase64('./bootstrapscript.sh') 


param nicwebserver_out string 
param nicadminId string 

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
          id: nicwebserver_out
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
          id: nicadminId
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


