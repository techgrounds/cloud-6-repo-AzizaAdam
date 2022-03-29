

param environment string = 'test'

param location string = resourceGroup().location



// params storage account, blobstroage, container, keyvault, managedId

// params for protected item, container for the recovery-vault and backup services
param recoveryvault_name string = 'recovault-${environment}'
param dailybackup_policy string = 'dailypolicy-${environment}'
param adminProtect string = 'vm;iaasvmcontainerv2;${resourceGroup().name};${vm_admin_NAME_out}'
param webProtect string = 'vm;iaasvmcontainerv2;${resourceGroup().name};${vm_web_NAME_out}'
param webcontainer string = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${vm_web_NAME_out}'
param admincontainer string = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${vm_admin_NAME_out}'
param fabricName string = 'Azurex'



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
    sourceResourceId: vmWebApp_ID_out
  }
}

resource adminprotection 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-12-01' = {
  name: '${recoveryvault_name}/${fabricName}/${admincontainer}/${adminProtect}'
  properties: {
    protectedItemType: 'Microsoft.ClassicCompute/virtualMachines'
    policyId: recovaultpolicy.id
    sourceResourceId: vm_admin_ID_out
  }
}


param vmWebApp_ID_out string 
param vm_web_NAME_out string 

param vm_admin_ID_out string 
param vm_admin_NAME_out string 


