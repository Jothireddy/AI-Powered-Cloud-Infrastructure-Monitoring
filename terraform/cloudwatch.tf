resource "aws_cloudwatch_log_group" "monitoring_logs" {
  name              = var.cloudwatch_log_group
  retention_in_days = 14

  tags = {
    Environment = "Production"
    Project     = "AICloudMonitoring"
  }
}
