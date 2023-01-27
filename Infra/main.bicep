param location string = resourceGroup().location
param envName string = 'man-sample-aca-environment'

param registry string
@secure()
param registryUsername string
@secure()
param registryPassword string

// Azure Log Analytics Workspace
resource law 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'man-sample-log-analytics-workspace'
  location: location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

// Azure Container Apps Environment
resource acaenv 'Microsoft.App/managedEnvironments@2022-06-01-preview' = {
  name: envName
  location: location
  properties: {    
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: law.properties.customerId
        sharedKey: law.listKeys().primarySharedKey
      }
    }
  }
}

// Azure Container Apps

// BackEnd1
module backend1 'containerApp.bicep' = {
  name: 'backend1'
  params: {
    name: 'backend1-app'
    location: location
    containerAppEnvId: acaenv.id
    containerImage: '${registry}/backend1:latest'
    containerPort: 80
    useExternalIngress: false
    daprAppId: 'backend1'
    registry: registry
    registryUsername: registryUsername
    registryPassword: registryPassword
  }
}

// BackEnd2
module backend2 'containerApp.bicep' = {
  name: 'backend2'
  params: {
    name: 'backend2-app'
    location: location
    containerAppEnvId: acaenv.id
    containerImage: '${registry}/backend2:latest'
    containerPort: 80
    useExternalIngress: false
    daprAppId: 'backend2'
    registry: registry
    registryUsername: registryUsername
    registryPassword: registryPassword
  }
}

// FrontEnd
module frontend 'containerApp.bicep' = {
  name: 'frontend'
  params: {
    name: 'frontend-app'
    location: location
    containerAppEnvId: acaenv.id
    containerImage: '${registry}/myfrontend:latest'
    containerPort: 80
    useExternalIngress: true
    daprAppId: 'my-front-end'
    registry: registry
    registryUsername: registryUsername
    registryPassword: registryPassword
  }
}
