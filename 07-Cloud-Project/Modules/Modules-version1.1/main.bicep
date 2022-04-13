// this the command to run this main.bicep file  >> az deployment sub create --location westeurope --template-file main.bicep
// all modules deploy successfully
// https://app.diagrams.net/ link to make the design of the project

// the private key I have them in my laptop in a folder, copy them to the admin server desktop then check the ip address of the running linux vm from the vmss instances and use it to ssh into the server.

// commands to log in from admin server to webserver:  
//ssh -i C:\Users\ziza\Desktop\id_rsa vmssuser@10.0.2.5
// sudo su
// apt update
//apt upgrade
// apt install stress
// sudo stress -cpu 100
//wait 5-10 min to see the autoscaling rules active :)

targetScope = 'subscription'
param environment string = 'test98'
param resourceGname string = 'rg${uniqueString(environment)}'
param location string = deployment().location 


resource projectresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name:resourceGname
  location:location
  tags: {
    tagName1: 'testing'
    tagName2: 'v1.1'
  }
  managedBy: 'string'
  properties: {} 
}
output projectResourcegroupName string = projectresourcegroup.name
output projectResourcegroupId string = projectresourcegroup.id

 // Vnet module
module moduleVnet 'moduleVnet2.bicep' = {
  name: 'Vnetwork_module'
  scope: projectresourcegroup
  params:{    
    location: location
    environment: environment
  }
}

// adding vnet peering module 
module module_vnetPeering 'moduleVnetPeering.bicep'={
  scope: projectresourcegroup
  name: 'module-vnetPeering'
  params: {
    vnetAdminId: moduleVnet.outputs.vnetAdminId
    vnetAdminName: moduleVnet.outputs.adminvnetname
    vnetvmssId: moduleVnet.outputs.vnetvmssId
    vnetvmssname: moduleVnet.outputs.vnetvmssname
  }
  dependsOn:[
    moduleVnet
  ]
}

// Admin server module
module moduleAdminserver 'module-adminserv.bicep' = {
  scope: projectresourcegroup
  name: 'adminServer_module'
  params:{
    adminUsername:'ziza'
    diskencryptId:moduleSTG_encryption.outputs.diskencryptionId
    nicadminId:moduleVnet.outputs.nicadminId
    location:location
    passadmin:'Mynameis@aziza123'
  }
  }


//storage and encryption module
module moduleSTG_encryption 'module-stg-encrp2.bicep'= {
  scope: projectresourcegroup
  name: 'module_storage_encryp'
  params:{
   location: location    
    policyoperation:'add'
  }
}


// module virtual machine scalesets and application gateway and Web Application Firewall (WAF)
module module_vmss_AGW 'module-vmss-AGW.bicep' = {
  scope: projectresourcegroup
  name: 'module_vmss_AGW'
  params: {
  SSLpassword: 'Myname@Aziza'
    diskencryptionId:moduleSTG_encryption.outputs.diskencryptionId
    AGWPipId: module_content_delivery_network.outputs.AGWPipId
    AGWSubnetId: moduleVnet.outputs.AGWSubnetId
    vmssSubnetId: moduleVnet.outputs.vmssSubnetId
    location: location
  }
}


// module backup and recoveryvault
module module_backup_recoveryVault 'module-backup-recovault.bicep' = {
  scope: projectresourcegroup
  name: 'module_backup_recoveryVault'
  params: {
    location:location
    vmAdmin_windowsId: moduleAdminserver.outputs.vmAdmin_windowsId
    vmAdmin_windowsName: moduleAdminserver.outputs.vmAdmin_windowsName
  }
}

// module CDN and LogAnalytics
module  module_content_delivery_network 'ModuleCDN.bicep' = {
  scope: projectresourcegroup
  name: 'module_CDN'
  params:{
    location:location
  }
}

// adding Azure Firewall module
//module module_AzureFirewall 'Module-Firewall.bicep'= {
 // scope: projectresourcegroup
 // name: 'module_Firewall'
  //params:{
  //  managedId: moduleSTG_encryption.outputs.managedId
  //  LogAnalyticsworkspaceId:module_content_delivery_network.outputs.LogAnalyticsworkspaceId
  //  location:location
  //  projectResourcegroupName: resourceGname
   // zones: []
   // subnetId: moduleVnet.outputs.FirewallSubnetId
 // }
 // dependsOn:[
  //  moduleVnet
  //]  
//}
