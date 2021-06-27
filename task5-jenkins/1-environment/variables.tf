
variable "aws_region" {
  description = "Please Enter AWS Region to deploy Infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "docker_count" {
  default = "2"
}