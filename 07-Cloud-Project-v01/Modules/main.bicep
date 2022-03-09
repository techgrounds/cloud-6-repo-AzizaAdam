// this the command to run this main.bicep file  >> az deployment sub create --location westeurope --template-file multipleRG.bicep
// Resource group
// all resources deploy only the admin VM needs some adjustment
targetScope = 'subscription'
param environment string = 'test'
param resourceGname string = 'rg${uniqueString(environment)}'


param location string = deployment().location 


resource projectresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name:resourceGname
    location:location
  tags: {
    tagName1: 'testing'
    tagName2: 'v1.0'
  }
  managedBy: 'string'
  properties: {} 
}

 // VM-vnet module plus // encryption moduel (keyvault, encryptionkeysets, managedId, storage account with customer managed encryption)

module module_VM_vnet_encrp_backup 'module-VM-vnet-encrp-backup.bicep' = {
  name: 'VM_network_module'
  scope: projectresourcegroup
  params:{
    location: location
    environment: environment
    pubkey:'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVvmAMi/zZWzXzEZEabevnUvL/PNEbqD42T5yfpsnN4c8EtBTjLMlyNffxGMsndbrpc5pr0aGP2GHfpT9F9uzqovFcswYnTrtieWXSnghuLynGICs9A6CACz0+M2lGvJ9Lnde9GZpjeIMe2AaOR4/jVYwdcu99Q6kkZx0I/tJzHXX7xMWAP2gFevYg7njQbTEyOGuTODfLwsC0oRNl+rE6xumWNiEvc+QuW75VboZwAepfboZtgwpCvsF2P+b0d1zKD0kP1YlISnCJw9GTuw1AZcQo7AFIsWb9K2YT2OWjcyJY+EVkIMds8npmOp0idkwfGh7XWVcFVSRxbf+K3LwrfseqmJdzUm+CNUNuySRP8a+1i6F9nvWzDV7moPU699xWlAEKgYfzmr3HbL3kSHQGtE5/ao7OvNCL4hpFP+DBu6YS8EY0JbCCJkrjNe72gmp3y5DtsE2DYDNX+Ys4v+ylOgIwmhvK3Rm952x1qXno2ABn5NB/uG+GAetoeYmZ45f4iTqaFPtK94xguqogNQVmxs46fn9DwjIUzK39DAnUA9dLP5ABYYbQDhFlLqulASYz0l0PxvS3J29J+GVNAr++JSTGmh0nC7tmDEL73wKcVAHilAAiHcI/p3k7r26zzDc08i/u/CjWfY1YdknCqxl6r7X74h5zZGu+fV4mMIKZxQ== zizan@LAPTOP-0KOJ4O3B'
    passadmin: 'ziza'
    diskencryptId: 'encryptionkeysets.id'
    adminPasswordOrKey: ''
    adminUsername:''
  }
}


