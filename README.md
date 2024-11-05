TP Terraform & Ansible - Infrastructure as Code (IaC)

Ce projet est une démonstration de l'infrastructure as code (IaC) utilisant Terraform et Ansible pour automatiser le déploiement et la configuration de ressources dans un environnement cloud. Il comprend plusieurs étapes, chacune visant à déployer et configurer des services spécifiques, incluant des conteneurs et une base de données.

Structure du projet

etape1 : Initialisation et configuration de l'infrastructure de base.

etape2 : Déploiement d'une base de données et configuration initiale avec Terraform.

etape3_aws : Provisionnement de l'infrastructure AWS pour les environnements de développement et de production.

etape4 : Reprise de l'étape 2 sur AWS, intégrant Ansible pour la gestion de la configuration.

etape5 : Déploiement d'une application WordPress avec un serveur Nginx, PHP-FPM et une base de données MariaDB, le tout dans un environnement conteneurisé sur AWS.

Prérequis

Terraform : pour provisionner l'infrastructure.

Ansible : pour configurer les serveurs une fois provisionnés.

Docker : pour gérer les conteneurs dans certaines étapes.

AWS CLI (facultatif) : pour interagir avec AWS en ligne de commande.

Assurez-vous d'avoir les bonnes permissions et configurations pour déployer sur AWS, et que Terraform et Ansible sont installés sur votre machine.

Configuration

Clonez le dépôt :

git clone https://github.com/naknak92/TP_TERAFORM.git
cd TP_TERAFORM

Initialisez les modules Terraform et téléchargez les providers :

terraform init

Personnalisez les fichiers de variables (*.tfvars) avec vos informations AWS et les configurations de votre environnement.

Pour chaque étape, utilisez Terraform pour appliquer les configurations :

terraform apply

Étapes

Étape 1

Déploiement des ressources de base.

Étape 2

Mise en place d'une base de données avec Terraform.

Étape 3 - AWS

Création de l'infrastructure sur AWS en vue de l'intégration dans un environnement cloud.

Étape 4 - Terraform & Ansible

Reprise de l'étape 2 avec Terraform et gestion de la configuration avec Ansible.

Étape 5 - Application WordPress

Déploiement d'un serveur WordPress avec Nginx, PHP-FPM et MariaDB sur des conteneurs Docker sur AWS.

Notes

Gestion des fichiers volumineux : Certains fichiers de configuration et providers sont exclus du dépôt pour respecter les limites de GitHub. Assurez-vous de bien initialiser les dépendances de Terraform et Docker.

Coûts AWS : Ce projet peut entraîner des frais sur AWS en fonction des ressources utilisées. Veillez à bien détruire les ressources (terraform destroy) lorsque vous avez terminé.

