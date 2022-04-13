// module vmss and application gateway

param location string = resourceGroup().location
param vmss_name string = 'vmss'
param applicationGateways_name string = 'AGW${uniqueString(resourceGroup().name)}'
param AGWPipId string 
param vmssSubnetId string 
param AGWSubnetId string 
param diskencryptionId string

// SSH key data, provide the data as a string.
param pubkey string = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVvmAMi/zZWzXzEZEabevnUvL/PNEbqD42T5yfpsnN4c8EtBTjLMlyNffxGMsndbrpc5pr0aGP2GHfpT9F9uzqovFcswYnTrtieWXSnghuLynGICs9A6CACz0+M2lGvJ9Lnde9GZpjeIMe2AaOR4/jVYwdcu99Q6kkZx0I/tJzHXX7xMWAP2gFevYg7njQbTEyOGuTODfLwsC0oRNl+rE6xumWNiEvc+QuW75VboZwAepfboZtgwpCvsF2P+b0d1zKD0kP1YlISnCJw9GTuw1AZcQo7AFIsWb9K2YT2OWjcyJY+EVkIMds8npmOp0idkwfGh7XWVcFVSRxbf+K3LwrfseqmJdzUm+CNUNuySRP8a+1i6F9nvWzDV7moPU699xWlAEKgYfzmr3HbL3kSHQGtE5/ao7OvNCL4hpFP+DBu6YS8EY0JbCCJkrjNe72gmp3y5DtsE2DYDNX+Ys4v+ylOgIwmhvK3Rm952x1qXno2ABn5NB/uG+GAetoeYmZ45f4iTqaFPtK94xguqogNQVmxs46fn9DwjIUzK39DAnUA9dLP5ABYYbQDhFlLqulASYz0l0PxvS3J29J+GVNAr++JSTGmh0nC7tmDEL73wKcVAHilAAiHcI/p3k7r26zzDc08i/u/CjWfY1YdknCqxl6r7X74h5zZGu+fV4mMIKZxQ== zizan@LAPTOP-0KOJ4O3B'
// commands to log in from admin server to webserver:  ssh -i C:\Users\ziza\Desktop\id_rsa vmssuser@10.0.2.5
// the private key I have them in my laptop in a folder 

var script64 = loadFileAsBase64('./bootstrapscript.sh') 
 
//generate SSL self signed certificate using the following link with windows powershell (you need to right click and open the 
//powershell as administrator otherwise access will be denied)
//the certificate will be .fpx file
// change the path to export the certificate to ur github directory immediately

// https://dzone.com/articles/how-to-create-a-self-signed-certificate-with-power


@secure()
param SSLpassword string


resource virtualMachineScaleSets_vmss 'Microsoft.Compute/virtualMachineScaleSets@2021-11-01' = {
  name: vmss_name
  location: location
  sku: {
    name: 'Standard_B1s'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    singlePlacementGroup: false
    orchestrationMode: 'Flexible'
    virtualMachineProfile: {
      osProfile: {
        customData: script64
        computerNamePrefix: vmss_name
        adminUsername: '${vmss_name}user'
        adminPassword: null
        linuxConfiguration: {
          disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              keyData: pubkey
              path: '/home/${vmss_name}user/.ssh/authorized_keys'
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
      storageProfile: {
        osDisk: {
          osType: 'Linux'
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            storageAccountType: 'Premium_LRS'
            diskEncryptionSet: {
              id: diskencryptionId
            }
          }
          diskSizeGB: 30
        }
        imageReference: {
          publisher: 'Canonical'
          offer: 'UbuntuServer'
          sku: '18.04-LTS'
          version: 'latest'
        }
      }
      extensionProfile: {
        extensions: [
          {
            name: 'HealthExtension'
            properties: {
              autoUpgradeMinorVersion: false
              publisher: 'Microsoft.ManagedServices'
              type: 'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
              settings: {
                protocol: 'http'
                port: 80
                requestPath: '/'
              }
            }
          }
        ]
      }
      networkProfile: {
        networkApiVersion:'2020-11-01'
        networkInterfaceConfigurations: [
          {
            name: '${vmss_name}nic'
            properties: {
              primary: true
              enableAcceleratedNetworking: false
              enableIPForwarding: false
              ipConfigurations: [
                {
                  name: '${vmss_name}ipconfig'
                  properties: {
                    subnet: {
                      id: vmssSubnetId
                    }
                    privateIPAddressVersion: 'IPv4'
                    applicationGatewayBackendAddressPools: [
                      {
                        id: applicationGateways.properties.backendAddressPools[0].id
                      }
                    ]
                  }
                }
              ]
              networkSecurityGroup: {
                id: networkSecurityGroups_vmss.id
            }
           }
          }
        ]
      }
    }
    platformFaultDomainCount: 1
    automaticRepairsPolicy: {
      enabled: true
      gracePeriod: 'PT30M'
    }
  }
}

output vmssName string = virtualMachineScaleSets_vmss.name
//adding NSG for the vmss
param NSGvmss_name string = 'NSGvmss_vm'

resource networkSecurityGroups_vmss 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: NSGvmss_name
  location: location
  properties: {
    securityRules: []
  }
}


// adding autoscaling rules
resource autoscalesettings_vmss 'microsoft.insights/autoscalesettings@2021-05-01-preview' = {
  name: 'autoscale_settings_vmss'
  location: location
  properties: {
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: '1'
          maximum: '3'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: virtualMachineScaleSets_vmss.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT10M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 75
              dividePerInstance: false
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT1M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: virtualMachineScaleSets_vmss.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 25
              dividePerInstance: false
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT1M'
            }
          }
        ]
      }
    ]
    enabled: true
    targetResourceUri: virtualMachineScaleSets_vmss.id
  }
}



output applicationGatewayName string = applicationGateways.name



@description('WAF Mode')
@allowed([
  'Detection'
  'Prevention'
])
param wafMode string = 'Detection'

@description('WAF Rule Set Type')
@allowed([
  'OWASP'
])
param wafRuleSetType string = 'OWASP'

@description('WAF Rule Set Version')
@allowed([
  '2.2.9'
  '3.0'
])
param wafRuleSetVersion string = '3.0'

resource applicationGateways 'Microsoft.Network/applicationGateways@2020-11-01' = {
  name: applicationGateways_name
  location: location
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
    }
    
    autoscaleConfiguration: {
      minCapacity: 1
      maxCapacity: 3
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          subnet: {
            id: AGWSubnetId
          }
        }
      }
    ]
    sslCertificates: [
      {
        name: '${applicationGateways_name}SslCercert'
        properties: {
          data:loadFileAsBase64 ('./cert.pfx')
          password:SSLpassword
        }
      }
    ]
    authenticationCertificates: []
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: AGWPipId
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGatewayFrontendPort'
        properties: {
          port: 443
        }
      }
      {
        name: 'httpPort'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'appGatewayBackendpool'
        properties: {
          backendAddresses: []
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          connectionDraining: {
            enabled: false
            drainTimeoutInSec: 1
          }
          pickHostNameFromBackendAddress: false
          requestTimeout: 30
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateways_name,'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateways_name,'appGatewayFrontendPort')
          }
          protocol: 'Https'
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates', applicationGateways_name, '${applicationGateways_name}SslCercert')
          }
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'myListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateways_name,'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateways_name, 'httpPort')
          }
          protocol: 'Http'
          hostNames: []
          requireServerNameIndication: false
        }
      }
    ]
    urlPathMaps: []
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateways_name, 'appGatewayHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateways_name, 'appGatewayBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateways_name, 'appGatewayBackendHttpSettings')
          }
        }
      }
      {
        name: 'rule2'
      properties: {
        ruleType: 'Basic'
        httpListener: {
          id: resourceId('Microsoft.Network/applicationGateways/httpListeners',applicationGateways_name, 'myListener')
        }
        redirectConfiguration: {
          id: resourceId('Microsoft.Network/applicationGateways/redirectConfigurations', applicationGateways_name, 'httpToHttps')
        }
      }
    }
  ]
  probes: []
  rewriteRuleSets: []
  redirectConfigurations: [
    {
      name: 'httpToHttps'
      properties: {
        redirectType: 'Permanent'
        targetListener: {
          id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateways_name, 'appGatewayHttpListener')
        }
        includePath: true
        includeQueryString: true
        requestRoutingRules: [
          {
            id: resourceId('Microsoft.Network/applicationGateways/requestRoutingRules',applicationGateways_name, 'rule2')
          }
        ]
      }
    }
  ]
  privateLinkConfigurations: []
  forceFirewallPolicyAssociation: true
  firewallPolicy: {
    id: Azure_WAF.id
  }
}
}
// adding Azure web application firewall
@description('The name of the resource.')
param wafName string ='waf${uniqueString(resourceGroup().name)}'

resource Azure_WAF 'Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies@2019-09-01' = {
  name: wafName
  location: location
  tags: {}
  properties: {
    customRules: []
    policySettings: {
      fileUploadLimitInMb: 100
      maxRequestBodySizeInKb: 128
      mode: wafMode
      requestBodyCheck: true
      state: 'Enabled'
    }
    managedRules: {
      exclusions: []
      managedRuleSets: [
        {
          ruleSetType: wafRuleSetType
          ruleSetVersion: wafRuleSetVersion
          ruleGroupOverrides: []
        }
      ]
    }
  }
}

