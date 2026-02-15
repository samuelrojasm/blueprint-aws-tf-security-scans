# terraform/Makefile

# ----------------------------------------------------------------
# Makefile Principal
# ----------------------------------------------------------------
include makefiles/config.mk
include makefiles/git.mk
include makefiles/aws.mk
include makefiles/tf-s3.mk

# Cargar el archivo .env si existe
# Exporta todas las variables del .env al entorno de los comandos
ifneq ("$(wildcard .env)","")
    include .env
    export $(shell sed 's/=.*//' .env)
endif

.PHONY: help
.DEFAULT_GOAL := help

# Definición de colores
YELLOW := \033[1;33m
GREEN  := \033[0;32m
CYAN   := \033[1;36m
RED    := \033[0;31m
RESET  := \033[0m

help:
	@echo ""
	@echo "$(CYAN)Uso: make [comando]$(RESET)"
	@echo ""
	@echo "$(YELLOW)Git:$(RESET)"
	@echo "  git-s3-root-sync       Git add, commit, push de root S3"
	@echo "  git-s3-module-sync     Git add, commit, push del módulo S3"
	@echo "  git-sg-root-sync       Git add, commit, push de root SG"
	@echo "  git-status             Muestra el estado de los archivos"
	@echo ""
	@echo "$(YELLOW)AWS:$(RESET)"
	@echo "  login-aws             Inicia sesión en AWS SSO"
	@echo "  check-auth            Verifica el estado de la sesión de AWS"
	@echo "  list-buckets          Listar buckets S3"
	@echo ""

# ---