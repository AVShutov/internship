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

output "ansible_public_ip" {
  description = "Public IP address of the Ansible EC2 instance"
  value       = aws_instance.ansible.public_ip
}

output "ansible_private_ip" {
  description = "Private IP address of the Ansible EC2 instance"
  value       = aws_instance.ansible.private_ip
}

output "ansible_public_dns" {
  description = "Public DNS name of the Ansible EC2 instance"
  value       = aws_instance.ansible.public_dns
}

output "docker_public_ip" {
  description = "Public IP addresses of the Docker EC2 instances"
  value       = aws_instance.docker.*.public_ip
}

output "docker_private_ip" {
  description = "Private IP addresses of the Docker EC2 instances"
  value       = aws_instance.docker.*.private_ip
}

output "docker_public_dns" {
  description = "Public DNS names of the Docker EC2 instances"
  value       = aws_instance.docker.*.public_dns
}