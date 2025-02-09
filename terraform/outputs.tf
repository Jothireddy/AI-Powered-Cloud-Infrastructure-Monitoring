output "cloudwatch_log_group" {
  description = "CloudWatch log group for infrastructure logs"
  value       = aws_cloudwatch_log_group.monitoring_logs.name
}

output "sagemaker_endpoint" {
  description = "SageMaker endpoint URL"
  value       = aws_sagemaker_endpoint.endpoint.endpoint_name
}

# (Optional) Output ELK instance public IP if provisioned via Terraform
output "elk_instance_public_ip" {
  description = "Public IP of the ELK stack instance"
  value       = aws_instance.elk_instance.public_ip
}
