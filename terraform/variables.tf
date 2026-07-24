variable "image_name" {
  description = "Docker image built by Jenkins"
  type        = string
  default     = "local-cicd-app:latest"
}

variable "container_name" {
  description = "Name of the deployed application container"
  type        = string
  default     = "final-project-app"
}

variable "external_port" {
  description = "Port used to access the application"
  type        = number
  default     = 8081
}