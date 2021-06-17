output "data_aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region_name" {
  value = data.aws_region.current.name
}

output "data_aws_region_description" {
  value = data.aws_region.current.description
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.docker.public_ip
}

output "public_dns" {
  description = "List of public DNS name assigned to the instances, if applicable"
  value       = aws_instance.docker.public_dns
}