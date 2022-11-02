# Scaleway
TpScaleway
# **READ ME :TP Scaleway Terraform, Sécurité et Réseaux**

Bille IHSAN 
Nathan BOULOGNE
LIEN HACK MD https://hackmd.io/pGx1zFCoS2efin1Y32GenA
**Cas n°1 : Bastion et règles de sécurités**

Pour le cas 1 nous allons donc installer une Base de données sur le cloud Scaleway , et pour cela nous allons utiliser Terraform.

Les prérequis pour pouvoir utiliser Terraform sur notre machine ainsi que pour pouvoir faire le lien avec Scaleway il faut : 
 Un compte Scaleway ainsi qu'un clé API lié à notre compte.
 Installer Terraform sur notre machine , pour cela nous allons utiliser "Chocolatey" qui est un gestionnaire de paquets windows.
 Nous commencons donc : 
> Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Puis une fois le logiciel installer nous pouvons installer Terraform.

> choco install terraform

Une fois terraform installer nous créons un dossier et navigons dedans 

> cd C:\Users\Terraform

Dans ce dossier nous créons un fichier en .tf ou nous rentrons notre code de déploiement.
Pour commencer le cas 1 nous allons mettre en place un script terraform qui établiera une connexion avec notre compte Scaleway 

- Fichier : debian\config.tf

Puis nous créons un script qui nous créra une instance debian. 

- Fichier : debian\debian.tf

Une fois créer , on exécute la commande dans le dossier :
> 
> terraform init 

![](https://i.imgur.com/8grerCV.png)



Une fois fais , on exécute la commande plan pour executer le script et la configuration :
>  terraform plan 

![](https://i.imgur.com/r2rRXcG.png)


Et enfin si tout reviens sans erreur , nous pouvons l'appliquer , ce qui effectuera le changement sur notre cloud Scaleway.

> terraform apply

On peut voir que le script s'est bien déployer.
![](https://i.imgur.com/bWgCaCV.png)

On peut voir notre instance dans notre interface Scaleway


![](https://i.imgur.com/522viVD.png)

Maintenant nous allons avec terraform créé une Base de donnée MySQL.

Nous reprenons notre dossier de configuration nous permettant de faire le lien Terraform avec Scaleway, et nous le mettons dans un nouveau dossier que nous appelerons "BDD"

-BDD\config.tf

Nous ajoutons au dossier un script nous permettant de créer une base de donnée Mysql sur notre scaleway.

-BDD\mysql.tf

Puis nous exécutons les 3 commandes terraform dans le dossier BDD pour déployer notre script et créer notre BDD

> terraform init
> terraform plan
> terraform apply

Le déploiement a bien été effectué.
 ![](https://i.imgur.com/VY86gxO.png)
 
On peut voir notre DBB mysql dans notre interface Scaleway.

![](https://i.imgur.com/v5E8c5A.png)

Une fois les deux machines créés nous nous connectons à notre instance debian en SSH.

> ssh root@51.15.211.17

Et nous installons Telnet et netcat.

> apt install Telnet 
> apt install netcat

Puis nous nous connectons depuis notre debian à notre BDD

> mysql -h 195.154.71.177 --port 41089 -p -u root

Et nous arrivons sur notre Base de données.

Maintenant , à des fins de test nous voulons créer des règles de sécurité permettant de bloquer certains ports sur notre machine debian. Pour cela nous allons bloquer le port 22 depuis notre hôte physique , et nous allons fais ça grâce à un script de security group que nous allons ajouter dans notre fichier debian , ce qui effectuera la modification.

On créé notre fichier de security groupe contenant les regles: 
- debian\secure.tf

Et nous exécutons les 3 commandes terraform afin de déployer le changement. 

> terraform init
> terraform plan
> terraform apply

Une fois effectué nous allons voir notre security groupe lié a notre machine debian sur l'interface Scaleway , afin de vérifier que la modification a bien été faite. 

![](https://i.imgur.com/8IYGiWE.png)

Le port 22 a bien été bloqué pour notre IP
On peut le vérifier en tentant de se connecter en SSH , qui donne une erreur.

Nous voulons ensuite sécuriser notre base de données Mysql , et pour cela nous allons utiliser des règles ACL afin de seulement autorisée l'ip de notre machine debian. 

Nous allons donc dans notre fichier DBB et créons un script contenant les règles ACL

- DBB\secure.tf

On exécute les 3 commandes terraform et on vérifie.
 ![](https://i.imgur.com/EUu0rDh.png)

La règle ACL fonctionne et notre machine a bien été autorisée.

**Cas n°2 : Réseaux virtuel privé et gateway**

Pour le second cas , nous pouvons supprimer les instances précedemment créer à l'aide de la commande terraform detroy

> terraform apply -destroy

Puis une fois effectué nous allons recommencer , en créant 2 VPC , avec un réseau contenant une machine debian , et l'autre 2 machine debian.

Nous créons donc le premier vpc contenant nos deux machines debian.
Nous créons donc un fichier vpc1 , nous entrons dedans , collant notre fichier config.tf qui ne change pas puis nous créons le script du vpc et des debian

- terraform\vpc2\vpc.tf

Nous éxecutons les trois commandes terraform et deployons notre script.

Nous pouvons voir que nous avons bien créer un réseau privé contenant 2 machine debian.

![](https://i.imgur.com/ij6YAxG.png)

Nous créons a présent le second VPC contenant qu'un machine.

nous faisons donc un nouveau fichier , mettons notre fichier config.tf puis créons notre script de déploiement

- terraform\vpc1\vpc.tf

On exécute le script. 
Et on voit le résultat
![](https://i.imgur.com/0SpDyfD.png)


En temps normal les réseaux privés aurait dû bloquer toute les connexions entre les machines des différent réseaux , malheuresement un défaut de configuration fera en sorte que les connexions entre les vpc soient possible.

Maintenant nous allons créer un gateway afin que les machine des deux VPC possèdent la même adresse ip publique.

Nous créons donc un script qui créra le gateway qui sera lié à notre instance scaleway 

- Terraform\Gateway\gateway.tf

Nous éxecutons le script et observons que nous avons bien créer un gateway lié à notre instance Scaleway.

![](https://i.imgur.com/WmNxMTt.png)

Puis une fois tout terminer nous supprimons toute nos instances avec 

> terraform apply -destroy


















