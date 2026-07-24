terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "application" {
  name         = var.image_name
  keep_locally = true
}

resource "docker_container" "application" {
  name  = var.container_name
  image = docker_image.application.image_id

  restart = "unless-stopped"

  ports {
    internal = 80
    external = var.external_port
  }
}