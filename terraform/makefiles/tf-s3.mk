# terraform/makefiles/tf-s3.mk

.PHONY: tf-s3-init

# Inicialización con caché (Garantiza que el volumen existe)
tf-s3-init: setup-cache check-auth ## Inicializa Terraform y descarga proveedores en caché
	@echo "🚀 Inicializando AWS S3 en $(S3_VULNERABLE_PATH)..."
	@$(DOCKER_TF) -chdir=$(S3_VULNERABLE_PATH) init

