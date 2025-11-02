terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.7.5"
    }
  }

  # This is Hetzner's Object Storage (Ceph)
  backend "s3" {
    bucket = "backend-advanced"
    key    = "backend-advanced/curriculum/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

variable "github_repository_token" {
  description = "Token for the GitHub repository"
  type        = string
  sensitive   = true
}

provider "github" {
  token = var.github_repository_token
  owner = "JobLoop-AS"
}
