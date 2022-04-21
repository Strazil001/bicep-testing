@description('Provide a location name')
param locationName string 

@description('Provide a name for the storage account')
param storageName string 

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'exampleVnet'
  location: locationName
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'Subnet-2'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

resource exampleStorage 'Microsoft.Storage/storageAccounts@2021-08-01' = {
	name: storageName
	location: locationName
	sku: {
		name: 'Standard_GRS'
	}
	kind: 'BlobStorage'
}
