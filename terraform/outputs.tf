output "application_url" {
  description = "URL for the deployed application"
  value       = "http://localhost:${var.external_port}"
}

output "container_name" {
  description = "Name of the deployed Docker container"
  value       = docker_container.application.name
}

output "container_id" {
  description = "ID of the deployed Docker container"
  value       = docker_container.application.id
}