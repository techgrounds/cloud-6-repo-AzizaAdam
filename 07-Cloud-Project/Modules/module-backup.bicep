
// adding backup and recovery vault service and backup policies
param location string = resourceGroup().location
param environment string = 'test'

// params for protected item, container for the recovery-vault and backup services
param recoveryvault_name string = 'recovault-${environment}'
param dailybackup_policy string = 'dailypolicy-${environment}'
// params for protected item, container for the recovery-vault and backup services
param adminProtect string = 'vm;iaasvmcontainerv2;${resourceGroup().name};${vmAdmin_windowsName}'
param admincontainer string = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${vmAdmin_windowsName}'
param fabricName string = 'Azurex'

param vmAdmin_windowsName string 




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

param vmAdmin_windowsId string 

resource adminprotection 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-12-01' = {
  name: '${recoveryvault_name}/${fabricName}/${admincontainer}/${adminProtect}'
  properties: {
    protectedItemType: 'Microsoft.ClassicCompute/virtualMachines'
    policyId: recovaultpolicy.id
    sourceResourceId: vmAdmin_windowsId
  }
}



output dialybackup_policy string = recovaultpolicy.name

output recoveryvault_name string = recoveryvault.name

output tenantId string = subscription().tenantId
