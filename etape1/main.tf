terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

# Provider Docker pour Terraform
provider "docker" {}

# Réseau Docker pour connecter les containers
resource "docker_network" "my_network" {
  name = "my_network"
}

# Container HTTP exécutant Nginx
resource "docker_container" "http" {
  name  = "HTTP"                    # Nom du container
  image = "nginx:latest"            # Image Docker pour Nginx

  # Mappage des ports
  ports {
    internal = 80                   # Port interne du container
    external = 8080                 # Port exposé sur la machine hôte
  }

  # Association au réseau Docker
  networks_advanced {
    name = docker_network.my_network.name
  }

  # Volume pour partager la configuration Nginx avec le container
  volumes {
    host_path      = abspath("${path.module}/app/default.conf")  # Utilisation d'un chemin absolu
    container_path = "/etc/nginx/conf.d/default.conf"            # Chemin dans le container
  }
}

# Container SCRIPT exécutant PHP-FPM
resource "docker_container" "script" {
  name  = "SCRIPT"                 # Nom du container
  image = "php:7.4-fpm"            # Image Docker pour PHP-FPM

  # Volume pour partager le répertoire contenant les fichiers PHP avec le container
  volumes {
    host_path      = abspath("${path.module}/app")  # Utilisation d'un chemin absolu
    container_path = "/app"                          # Chemin dans le container
  }

  # Association au réseau Docker
  networks_advanced {
    name = docker_network.my_network.name
  }
}



