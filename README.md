# AI-Powered Cloud Infrastructure Monitoring

This project implements an AI-based anomaly detection system for cloud logs by combining AWS services and open‑source tools. The solution includes:

- **AWS CloudWatch** for log collection.
- **ELK Stack (Elasticsearch, Logstash, Kibana)** for log indexing and visualization.
- **AWS SageMaker** to train and deploy a machine learning model for anomaly detection.

The entire infrastructure is provisioned via Terraform, and custom Python scripts are provided for model training and inference. The ELK stack is deployed using Docker Compose.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup & Deployment](#setup--deployment)
  - [Terraform Infrastructure](#terraform-infrastructure)
  - [ELK Deployment](#elk-deployment)
  - [SageMaker Model Training & Inference](#sagemaker-model-training--inference)
- [Usage & Testing](#usage--testing)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Overview

This project creates a scalable monitoring system that:
- **Collects logs** from your AWS resources via CloudWatch.
- **Indexes and visualizes** logs using an ELK stack.
- **Detects anomalies** by training a machine learning model on historical log data with AWS SageMaker.
- **Provides an endpoint** for real‑time anomaly scoring on new log events.

## Architecture

1. **CloudWatch:** Aggregates logs from various AWS services.
2. **ELK Stack:** Deployed using Docker Compose to enable real‑time log visualization and search.
3. **SageMaker:** A training job processes historical log data to build an anomaly detection model (e.g., using Isolation Forest). The model is then deployed as an endpoint for inference.


## Prerequisites

- AWS Account with permissions for CloudWatch, SageMaker, and (optionally) EC2.
- Terraform (v1.0+)
- AWS CLI (configured with your credentials)
- Docker & Docker Compose (for deploying the ELK stack)
- Python 3.7+ (for training/inference and local testing)
- Git

## Setup & Deployment

### Terraform Infrastructure

1. **Clone the repository:**
 ```bash
   git clone <repository_url>
```
Configure Variables: Edit terraform/variables.tf to set your desired AWS region, bucket names, SageMaker parameters, etc.

Deploy Infrastructure with Terraform:

```
cd terraform
terraform init
terraform plan -out=tfplan
terraform apply -auto-approve tfplan
```
This will provision:

CloudWatch log groups (and optionally subscription filters)
A SageMaker training job and model endpoint
(Optionally) an EC2 instance for the ELK stack (or you can deploy ELK separately using Docker Compose)
ELK Deployment
Deploy the ELK Stack: Navigate to the elk/ directory and run the deployment script:
```
cd elk
docker-compose up -d
```
Alternatively, run the helper script from the root:
```
cd scripts
./deploy_elk.sh
```
## SageMaker Model Training & Inference
Model Training: In the sagemaker/ directory, review and (if needed) modify train.py to customize data ingestion and model training. Package and run the training job via SageMaker (this can be triggered via the Terraform configuration or manually).

Model Inference: The deployed SageMaker endpoint uses the inference script (inference.py) to score new log events for anomalies. Test the endpoint using sample payloads.

## Usage & Testing
View Logs in Kibana:
Open your browser and navigate to the Kibana URL (output by your ELK deployment) to explore your logs.
## Invoke the SageMaker Endpoint:
Use the AWS CLI or a custom client to send log data to your SageMaker endpoint and receive anomaly scores.
## Monitor CloudWatch:
Check CloudWatch to verify that logs are being collected from your AWS resources.
## Troubleshooting
Terraform Errors:
Ensure your AWS credentials are set and that resource names (e.g., S3 buckets, log groups) are unique.
ELK Stack Issues:
Check Docker container logs with docker-compose logs to diagnose any issues with Elasticsearch, Logstash, or Kibana.
SageMaker Failures:
Review CloudWatch logs for the SageMaker training job and endpoint for error messages.
## Contributing
Contributions are welcome! Please fork the repository, create your feature branch, and open a pull request with your improvements.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

Happy monitoring and anomaly detection!


