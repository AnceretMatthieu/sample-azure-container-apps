# Azure Container Apps sample

Il s'agit du code source du projet d'exemple utilisé pour illustrer [l'article sur les Azure Containers Apps de mon blog](https://anceret-matthieu.fr/2023/01/les-conteneurs-dans-azure-focus-azure-container-apps/).

![Schéma d'architecture](https://res.cloudinary.com/anceret-matthieu/image/upload/v1674724698/posts/azure-containers/aca-sample-architecture-diagram.pngg)

Le projet est composé de 3 briques : 
- **FrontEnd** : site web ASP.Net Core chargé d'afficher le contenu en provenance des briques BackEnd
- **BackEnd1** : web API .NET Core chargée d'exposer la météo (sample de Microsoft)
- **BackEnd2** : web API .NET Core chargée d'exposer des informations sur des produits (générés aléatoirement via [Bogus](https://github.com/bchavez/Bogus)) 

## Local run

Le projet peut-être démarré en local via *docker-compose* : 
`docker-compose up -d`

## Azure run

Le projet peut aussi être déployé sur Azure.

Pour cela, il est nécessaire de créer les prérequis suivants : 
- un groupe de ressource
- un registre de conteneurs (ACR ou autre)
- builder et déposer les images des 3 briques dans le registre (via VS ou via une chaine de CI)

Pour devez ensuite récupérer les informations d'authentification de votre registre.
Dans le cas d'ACR, voici la commande Azure CLI : 
`az acr credential show -n <acr-name>`

Puis de lancer le déploiement : 
`az deployment group create -n container-app -g <rg-name> --template-file .\main.bicep -p registry=<acr-name>.azurecr.io registryUsername=<username> registryPassword<password>`