param location string
param name string
param containerAppEnvId string

param containerImage string
param containerPort int
param useExternalIngress bool

param daprAppId string

param registry string
@secure()
param registryUsername string
@secure()
param registryPassword string

// Azure Container Apps
resource containerApp 'Microsoft.App/containerApps@2022-06-01-preview' = {
  name: name
  location: location
  properties: {
    managedEnvironmentId: containerAppEnvId
    configuration: {
      dapr: {
        appId: daprAppId
        appPort: 80
        appProtocol: 'http'
        enabled: true
      }
      ingress: {
        external: useExternalIngress
        targetPort: containerPort
      }
      secrets: [
        {
          name: 'container-registry-password'
          value: registryPassword
        }
      ]
      registries: [
        {
          server: registry
          username: registryUsername
          passwordSecretRef: 'container-registry-password'
        }
      ]      
    }
    template: {
      containers: [
        {
          image: containerImage
          name: name
        }
      ]
      scale: {
        minReplicas: 0
      }
    }
  }
}
