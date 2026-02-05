# terraform/makefiles/aws.mk

# ----------------------------
# AWS - Tareas (Targets)
# ----------------------------

# Comandos de AWS
.PHONY: login-aws check-auth list-buckets

# Autenticación
login-aws: ## Inicia sesión en AWS SSO usando el perfil configurado
	@echo "Iniciando sesión SSO para el perfil $(AWS_PROFILE)..."
	@echo "Copia el código que aparecerá a continuación en tu navegador..."
	@$(DOCKER_AWS_CLI) sso login --profile $(AWS_PROFILE) --no-browser

list-buckets:
	$(DOCKER_AWS_CLI) s3 ls --profile $(AWS_PROFILE)

# Target de validación
check-auth: ## Verifica el estado de la sesión de AWS
	@echo "Verificando sesión de AWS..."
	@$(DOCKER_AWS_CLI) sts get-caller-identity --profile $(AWS_PROFILE) > /dev/null || \
	(echo "Error: La sesión de AWS ha expirado. Ejecuta 'make login-aws'"; exit 1)

# ---