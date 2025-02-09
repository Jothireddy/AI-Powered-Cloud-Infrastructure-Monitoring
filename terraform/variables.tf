variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "cloudwatch_log_group" {
  description = "Name of the CloudWatch log group for infrastructure logs"
  type        = string
  default     = "/aws/ai-cloud-monitoring/logs"
}

# SageMaker variables
variable "sagemaker_role_arn" {
  description = "ARN of the IAM role for SageMaker (should have necessary permissions)"
  type        = string
}

variable "sagemaker_job_name" {
  description = "Name of the SageMaker training job"
  type        = string
  default     = "ai-monitoring-training-job"
}

variable "sagemaker_endpoint_name" {
  description = "Name of the SageMaker endpoint for inference"
  type        = string
  default     = "ai-monitoring-endpoint"
}

# (Optional) ELK deployment variables if provisioning an EC2 instance for ELK
variable "elk_instance_type" {
  description = "EC2 instance type for ELK stack"
  type        = string
  default     = "t3.small"
}

variable "elk_key_name" {
  description = "EC2 Key Pair name for accessing the ELK instance"
  type        = string
  default     = "your-key-pair-name"
}
