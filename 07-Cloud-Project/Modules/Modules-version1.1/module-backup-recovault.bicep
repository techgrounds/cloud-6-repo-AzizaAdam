
// adding backup and recovery vault service and backup policies


param location string = resourceGroup().location
param environment string = 'test'
param recoveryvault_name string = 'recovault-${environment}'
param dailybackup_policy string = 'dailypolicy-${environment}'

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

param vmAdmin_windowsId string 
param vmAdmin_windowsName string 

var pContainer_vmadmin = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${vmAdmin_windowsName}'
var pItem_vmadmin = 'vm;iaasvmcontainerv2;${resourceGroup().name};${vmAdmin_windowsName}'
var backupFabric = 'Azurex'



resource protecteditem_adminserver 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-12-01' = {
  name: '${recoveryvault_name}/${backupFabric}/${pContainer_vmadmin}/${pItem_vmadmin}'
  properties: {
    protectedItemType: 'Microsoft.Compute/virtualMachines'
    policyId: recovaultpolicy.id
    sourceResourceId: vmAdmin_windowsId
  }
}
