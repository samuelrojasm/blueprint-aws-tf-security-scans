# storage/main.tf

locals {
  bucket_name = "$(var.project_name)-$(var.env)-$(var.aws_region)-tf-data-sensible"
}

module "s3_bucket" {
  source      = "../../../../modules/storage/s3-vulnerable"
  bucket_name = "${local.bucket_name}"
}

# ---