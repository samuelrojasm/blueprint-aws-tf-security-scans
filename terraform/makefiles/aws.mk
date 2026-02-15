# terraform/makefiles/aws.mk

# ----------------------------
# AWS - Tareas (Targets)
# ----------------------------

# Comandos de AWS
.PHONY: login-aws check-auth list-buckets

# Autenticación
login-aws: ## Inicia sesión en AWS SSO usando el perfil configurado
	@echo ""
	@echo "$(YELLOW)Iniciando sesión SSO para el perfil: $(AWS_PROFILE)...$(RESET)"
	@echo "----------------------------"
	@echo "$(CYAN)Copia el código que aparecerá a continuación en tu navegador...$(RESET)"
	@echo ""
	@$(DOCKER_AWS_CLI) sso login --profile $(AWS_PROFILE) --no-browser

list-buckets: check-auth ## Lista los buckets S3
	@echo ""
	@echo "$(YELLOW)Listando buckets S3...$(RESET)"
	@echo "----------------------------"
	@$(DOCKER_AWS_CLI) s3 ls --profile $(AWS_PROFILE)

check-auth: ## Verifica el estado de la sesión de AWS
	@echo ""
	@echo "$(YELLOW)Verificando sesión...$(RESET)"
	@echo "----------------------------"
	@if $(DOCKER_AWS_CLI) sts get-caller-identity --profile $(AWS_PROFILE) > /dev/null; then \
		echo "$(GREEN)✅ Sesión Valida$(RESET)"; \
	else \
		(echo "$(RED)❌ Error: La sesión de AWS ha expirado. Ejecuta 'make login-aws'$(RESET)"); \
		exit 1; \
	fi

# ---