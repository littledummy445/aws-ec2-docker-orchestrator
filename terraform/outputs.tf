output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.docker_host.public_ip
}

output "application_url" {
  description = "Direct browser URL for the deployed application"
  value       = "http://${aws_instance.docker_host.public_ip}"
}
