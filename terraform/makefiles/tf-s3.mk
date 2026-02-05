# terraform/makefiles/tf-s3.mk

.PHONY: tf-s3-init

# Inicialización con caché (Garantiza que el volumen existe)
tf-s3-init: setup-cache check-auth ## Inicializa Terraform y descarga proveedores en caché
	@echo "🚀 Inicializando AWS S3 en $(S3_VULNERABLE_PATH)..."
	@$(DOCKER_TF) -chdir=$(S3_VULNERABLE_PATH) init

tf-s3-plan: check-auth ## Muestra el plan de ejecución de Terraform
	@$(DOCKER_TF) -chdir=$(S3_VULNERABLE_PATH) plan
 
tf-s3-apply: check-auth
	@echo "🏗️ Creando ..."
	@$(DOCKER_TF) -chdir=$(S3_VULNERABLE_PATH) apply -auto-approve

tf-s3-destroy: confirm check-auth ## Destruye los recursos generados
	@$(DOCKER_TF) -chdir=$(S3_VULNERABLE_PATH) destroy -auto-approve

tf-s3-state-list: check-auth ## Muestra los nombres e IDs de los recursos
	@$(DOCKER_TF) -chdir=$(S3_VULNERABLE_PATH) state list