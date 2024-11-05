terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

# Création d'un réseau Docker pour connecter les containers
resource "docker_network" "my_network" {
  name = "my_network_etape2"
}

# Container HTTP exécutant Nginx
resource "docker_container" "http" {
  name  = "HTTP"
  image = "nginx:latest"

  # Exposer le port 8080 pour l'accès HTTP
  ports {
    internal = 80
    external = 8080
  }

  # Associer au réseau Docker
  networks_advanced {
    name = docker_network.my_network.name
  }

  # Volume pour la configuration Nginx et les fichiers PHP
  volumes {
    host_path      = abspath("${path.module}/app/default.conf")
    container_path = "/etc/nginx/conf.d/default.conf"
  }

  volumes {
    host_path      = abspath("${path.module}/app")
    container_path = "/app"
  }
}

# Container SCRIPT exécutant PHP-FPM avec l'extension pdo_mysql
resource "docker_container" "script" {
  name  = "SCRIPT"
  image = "php:7.4-fpm"

  # Commande pour installer l'extension pdo_mysql avant de démarrer PHP-FPM
  command = [
    "/bin/sh", "-c",
    "docker-php-ext-install pdo_mysql && php-fpm"
  ]

  # Volume pour les fichiers PHP
  volumes {
    host_path      = abspath("${path.module}/app")
    container_path = "/app"
  }

  networks_advanced {
    name = docker_network.my_network.name
  }
}

# Container DATA exécutant MariaDB pour la base de données
resource "docker_container" "data" {
  name  = "DATA"
  image = "mariadb:latest"

  # Variables d'environnement pour configurer la base de données
  env = [
    "MYSQL_ROOT_PASSWORD=root_password",
    "MYSQL_DATABASE=testdb",
    "MYSQL_USER=testuser",
    "MYSQL_PASSWORD=testpassword"
  ]

  networks_advanced {
    name = docker_network.my_network.name
  }

  # Exposer le port pour la base de données
  ports {
    internal = 3306
    external = 3306
  }

  # Volume pour stocker les données de MariaDB
  volumes {
    container_path = "/var/lib/mysql"
    host_path      = abspath("${path.module}/data/mysql")
  }
}

