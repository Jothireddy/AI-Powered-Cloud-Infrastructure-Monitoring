resource "aws_instance" "elk_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.elk_instance_type
  key_name      = var.elk_key_name
  vpc_security_group_ids = [aws_security_group.elk_sg.id]
  subnet_id     = data.aws_subnet.default.id

  tags = {
    Name = "ELK-Stack-Instance"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.default.id]
  }
  most_recent = true
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "elk_sg" {
  name        = "elk-sg"
  description = "Allow access to ELK stack"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 5601  # Kibana
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9200  # Elasticsearch
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5044  # Logstash Beats input
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
