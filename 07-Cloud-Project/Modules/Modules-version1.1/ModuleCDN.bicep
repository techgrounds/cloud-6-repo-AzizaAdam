
// aading Azure CDN service and LogAnalytics workspace
//https://docs.microsoft.com/en-us/azure/cdn/cdn-add-to-web-app
//https://github.com/Azure/bicep/blob/main/docs/examples/201/cdn-with-storage-account/main.bicep
//https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.cdn/cdn-with-web-app/main.bicep 


@description('Name of the CDN Profile')
param profileName string ='CDN-${uniqueString(resourceGroup().id)}'

@description('Name of the CDN Endpoint, must be unique')
param endpointName string = 'endpoint-${uniqueString(resourceGroup().id)}'

@description('CDN SKU names')
@allowed([
  'Standard_Akamai'
  'Standard_Microsoft'
  'Standard_Verizon'
  'Premium_Verizon'
])
param CDNSku string = 'Standard_Microsoft'

@description('Location for all resources.')
param location string = resourceGroup().location


resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: profileName
  location: location
  sku: {
    name: CDNSku
  }
}


// I added the public IP address of the applicationgateways to be connected to the endpoint to accellerate the caching from the webserver
param publicIPAddresses_AGW_name string = 'AGWpubIP'


// adding public IP to the application gateway
resource publicIPAddresses_AGW 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_AGW_name
  location: location
  sku: {
    name: 'Standard'
  }
  zones: [
    '1'
  ]
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}


output AGWPipId string = publicIPAddresses_AGW.id
output AGWPipname string = publicIPAddresses_AGW.name


resource endpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  parent: profile
  name: endpointName
  location: location
  properties: {
    originHostHeader: publicIPAddresses_AGW.properties.ipAddress
    isHttpAllowed: true
    isHttpsAllowed: true
    queryStringCachingBehavior: 'IgnoreQueryString'
    contentTypesToCompress: [
      'application/eot'
      'application/font'
      'application/font-sfnt'
      'application/javascript'
      'application/json'
      'application/opentype'
      'application/otf'
      'application/pkcs7-mime'
      'application/truetype'
      'application/ttf'
      'application/vnd.ms-fontobject'
      'application/xhtml+xml'
      'application/xml'
      'application/xml+rss'
      'application/x-font-opentype'
      'application/x-font-truetype'
      'application/x-font-ttf'
      'application/x-httpd-cgi'
      'application/x-javascript'
      'application/x-mpegurl'
      'application/x-opentype'
      'application/x-otf'
      'application/x-perl'
      'application/x-ttf'
      'font/eot'
      'font/ttf'
      'font/otf'
      'font/opentype'
      'image/svg+xml'
      'text/css'
      'text/csv'
      'text/html'
      'text/javascript'
      'text/js'
      'text/plain'
      'text/richtext'
      'text/tab-separated-values'
      'text/xml'
      'text/x-script'
      'text/x-component'
      'text/x-java-source'
    ]
    isCompressionEnabled: true
    origins: [
      {
        name: 'origin1'
        properties: {
          hostName: publicIPAddresses_AGW.properties.ipAddress
        }
      }
    ]
    
    deliveryPolicy: {
      description: 'Path based Cache Override'
      rules: [
        {
          name: 'Pathmatchcondition'
          order: 1
          conditions: [
            {
              name: 'UrlPath'
              parameters: {
                typeName: 'DeliveryRuleUrlPathMatchConditionParameters'
                operator: 'BeginsWith'
                matchValues: [
                  '/images/'
                ]
              }
            }
          ]
          actions: [
            {
              name: 'CacheExpiration'
              parameters: {
                typeName: 'DeliveryRuleCacheExpirationActionParameters'
                cacheBehavior: 'Override'
                cacheType: 'All'
                cacheDuration: '00:00:30'
              }
            }
          ]
        }
      ]
    }
  }
}



// adding existing application gateway resource
// param applicationGatewayName string 

// resource applicationGateways 'Microsoft.Network/applicationGateways@2020-11-01' existing = {
//   name: applicationGatewayName
//}

param LogAnalytics_workspace_name string = 'CDN-workspace${subscription().tenantId}'

resource LogAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview'={
  name: LogAnalytics_workspace_name
  location: location
  properties:{
    sku:{
      name: 'PerGB2018'
    }
    retentionInDays: 30
    features:{
      enableLogAccessUsingOnlyResourcePermissions:true
    }
    workspaceCapping:{
      dailyQuotaGb: -1
    }
    publicNetworkAccessForIngestion:'Enabled'
    publicNetworkAccessForQuery:'Enabled'
  }
}
output LogAnalyticsworkspaceId string = LogAnalyticsWorkspace.id
output LogAnalyticsworkspaceName string = LogAnalyticsWorkspace.name

