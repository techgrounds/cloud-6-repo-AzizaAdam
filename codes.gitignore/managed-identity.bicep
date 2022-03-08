param userAssignedIdentities_name string = 'identitydeom1'

resource userAssignedIdentities_identity566_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: userAssignedIdentities_name
  location: 'westeurope'
}
