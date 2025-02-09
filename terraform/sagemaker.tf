resource "aws_sagemaker_training_job" "training_job" {
  name              = var.sagemaker_job_name
  role_arn          = var.sagemaker_role_arn
  algorithm_specification {
    training_image     = "382416733822.dkr.ecr.us-east-1.amazonaws.com/linear-learner:latest"
    training_input_mode = "File"
  }
  input_data_config {
    channel_name = "training"
    data_source {
      s3_data_source {
        s3_data_type = "S3Prefix"
        s3_uri       = "s3://your-training-data-bucket/path/"
      }
    }
  }
  output_data_config {
    s3_output_path = "s3://your-model-artifacts-bucket/path/"
  }
  resource_config {
    instance_count = 1
    instance_type  = "ml.m5.xlarge"
    volume_size_in_gb = 10
  }
  stopping_condition {
    max_runtime_in_seconds = 3600
  }
}

resource "aws_sagemaker_model" "model" {
  name          = "${var.sagemaker_job_name}-model"
  execution_role_arn = var.sagemaker_role_arn

  primary_container {
    image     = "382416733822.dkr.ecr.us-east-1.amazonaws.com/linear-learner:latest"
    model_data_url = aws_sagemaker_training_job.training_job.output_data_config[0].s3_output_path
  }
}

resource "aws_sagemaker_endpoint_configuration" "endpoint_config" {
  name = "${var.sagemaker_endpoint_name}-config"

  production_variants {
    variant_name           = "AllTraffic"
    model_name             = aws_sagemaker_model.model.name
    initial_instance_count = 1
    instance_type          = "ml.m5.xlarge"
  }
}

resource "aws_sagemaker_endpoint" "endpoint" {
  name                 = var.sagemaker_endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.endpoint_config.name
}
