/* module needs a lot of work, has not been tested for obious reasons
this will launch:
- recovery vault
- backuppolicies
- protected items (adminserver & webserver)
*/

targetScope = 'resourceGroup'

@description('parameters to get out of main file')
param location string


@description('naming of the resources')
param recoveryvaultName string = 'recvault${uniqueString(resourceGroup().id)}'
param backupPoliciesName string = 'backupPolicy${uniqueString(resourceGroup().id)}'
//param protectedName1 string = 'prtAdmin${uniqueString(resourceGroup().id)}'
//param protectedName2 string = 'prtWeb${uniqueString(resourceGroup().id)}'

resource recoveryVault 'Microsoft.RecoveryServices/vaults@2021-11-01-preview' = {
  name: recoveryvaultName
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource backupPolicies 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-12-01' = {
  parent: recoveryVault
  name: backupPoliciesName
  location: location
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2022-03-08T08:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2022-03-08T08:00:00Z'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}
