param managedId_name string = 'validationid'
param location string = resourceGroup().location

resource userAssignedIdentities 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedId_name
  location: location
}

output managed_id string = userAssignedIdentities.id
output managed_id_access string = userAssignedIdentities.properties.principalId

// https://ochzhen.com/tags/#infrastructure-as-code
