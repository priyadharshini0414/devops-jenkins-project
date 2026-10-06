terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "web" {
  name = "devops-web:latest"
  build {
    context = "${path.module}/../docker"
  }
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "web-server"
  image = docker_image.web.image_id

  ports {
    internal = 80
    external = 8081
  }
}
