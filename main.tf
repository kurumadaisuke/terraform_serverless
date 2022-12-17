terraform {
  required_version = "= 1.3.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.24.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
}

variable "project" {
  type = string
}
variable "environment" {
  type = string
}