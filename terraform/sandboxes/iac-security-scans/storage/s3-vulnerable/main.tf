# storage/main.tf

locals {
  bucket_name = "$(var.project_name)-$(var.env)-$(var.aws_region)-tf-data-sensible"

  common_tags = {
    Env       = var.env
    ManagedBy = "Terraform"
    Project   = var.project_name
    Owner     = "CloudAutomationTeam"
  }
}

terraform {
  backend "s3" {
    bucket         = "iac-security-scans-sandbox-us-east-1-terraform-tfstate"
    key            = "s3-vulnerable/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
  }
}

module "s3_bucket" {
  source      = "../../../../modules/storage/s3-vulnerable"
  bucket_name = local.bucket_name
  tags =  local.common_tags
}

# ---