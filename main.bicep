param location string = resourceGroup().location
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

@allowed([
	'test'
	'prod'
])
param environmentType string

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
	name: storageAccountName
	location: location
	sku: {
		name: storageAccountSkuName
	}
	kind: 'StorageV2'
	properties: {
		accessTier: 'Hot'
	}
}

module appService 'modules/appService.bicep' = {
	name: 'appService'
	params: {
		appServiceAppName: appServiceAppName
		environmentType: environmentType
		location: location
	}
}

output appServiceAppHostName string = appService.outputs.appServiceAppHostName
