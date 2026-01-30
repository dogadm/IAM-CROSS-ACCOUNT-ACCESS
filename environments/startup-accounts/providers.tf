terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Bootstrap deployment into member accounts using OrganizationAccountAccessRole.
# Source credentials come from your "management" profile.
# This is the cleanest way to create roles across accounts initially.
provider "aws" {
  alias   = "dev"
  region  = var.region
  profile = var.source_profile

  assume_role {
    role_arn = "arn:aws:iam::${var.accounts.dev}:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias   = "uat"
  region  = var.region
  profile = var.source_profile

  assume_role {
    role_arn = "arn:aws:iam::${var.accounts.uat}:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias   = "prod2"
  region  = var.region
  profile = var.source_profile

  assume_role {
    role_arn = "arn:aws:iam::${var.accounts.prod2}:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias   = "gaming"
  region  = var.region
  profile = var.source_profile

  assume_role {
    role_arn = "arn:aws:iam::${var.accounts.gaming}:role/OrganizationAccountAccessRole"
  }
}

