terraform {
    backend "s3" {}
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
      }
    }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_elastic_beanstalk_application" "app" {
  name = join("-", ["demo-aws-app",var.environment])
  description = "simple app to demonstrate DevOps workflows in AWS."
  tags = {
    owner = "daniel.kemnitz@atos.net"
  }
}

resource "aws_elastic_beanstalk_environment" "env" {
  name = join("-", ["demo-aws-app-env",var.environment])
  depends_on = [ aws_elastic_beanstalk_application.app ]
  application = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2023 v5.1.2 running Tomcat 10 Corretto 17"
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }
  tags = {
    owner = "daniel.kemnitz@atos.net"
  }
}

resource "aws_db_instance" "db" {
  allocated_storage = 1
  db_name = "preferences"
  engine = "mysql"
  instance_class = "t4g.nano"
  username = var.db_username
  password = var.db_password
  port = 3306
  tags = {
    owner = "daniel.kemnitz@atos.net"
  }
}
