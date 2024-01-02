terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
      }
    }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_elastic_beanstalk_application" "app" {
  name = "demo-aws-app"
  description = "simple app to demonstrate DevOps workflows in AWS."
  tags = {
    owner = "daniel.kemnitz@atos.net"
    env = "dev"
  }
}

resource "aws_elastic_beanstalk_environment" "env" {
  name = "demo-aws-app-env"
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
    env = "dev"
  }
}