{
  "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
      "location": {
          "type": "string"
      },
      "extendedLocation": {
          "type": "object"
      },
      "virtualNetworkName": {
          "type": "string"
      },
      "resourceGroup": {
          "type": "string"
      },
      "addressSpaces": {
          "type": "array"
      },
      "ipv6Enabled": {
          "type": "bool"
      },
      "subnetCount": {
          "type": "int"
      },
      "subnet0_name": {
          "type": "string"
      },
      "subnet0_addressRange": {
          "type": "string"
      },
      "ddosProtectionPlanEnabled": {
          "type": "bool"
      },
      "firewallEnabled": {
          "type": "bool"
      },
      "bastionEnabled": {
          "type": "bool"
      }
  },
  "variables": {},
  "resources": [
      {
          "name": "[parameters('virtualNetworkName')]",
          "type": "Microsoft.Network/VirtualNetworks",
          "apiVersion": "2021-01-01",
          "location": "[parameters('location')]",
          "extendedLocation": "[if(empty(parameters('extendedLocation')), json('null'), parameters('extendedLocation'))]",
          "dependsOn": [],
          "tags": {
              "project": "vnet"
          },
          "properties": {
              "addressSpace": {
                  "addressPrefixes": [
                      "10.1.0.0/16",
                      "10.10.10.0/24"
                  ]
              },
              "subnets": [
                  {
                      "name": "default",
                      "properties": {
                          "addressPrefix": "10.1.0.0/24"
                      }
                  }
              ],
              "enableDdosProtection": "[parameters('ddosProtectionPlanEnabled')]"
          }
      }
  ]
}

