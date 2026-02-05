# main.tf

# ❌ ESTE CÓDIGO TIENE VULNERABILIDADES INTENCIONALES

#----------------------------------
# Crea Bucket S3
#----------------------------------
resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket = "${var.bucket_name}"

  # Vulnerabilidad 1: ACL pública (Obsolescente pero detectable)
  # Checkov detectará que el bucket podría ser expuesto.

  # Protección contra eliminación accidental desde Terraform
  lifecycle {
    # prevent_destroy = true  # Entornos Dev o Prod
    prevent_destroy = false   # Entornos de test o Sandbox que son emíferos
  }

  tags = {
    Name        = "Terraform Bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "bad_config" {
  bucket = aws_s3_bucket.vulnerable_bucket.id

  # Vulnerabilidad 2: Configuración de acceso público desactivada
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Vulnerabilidad 3: Falta de cifrado en reposo (Encryption)
# No estamos declarando el recurso 'aws_s3_bucket_server_side_encryption_configuration'


# ---

