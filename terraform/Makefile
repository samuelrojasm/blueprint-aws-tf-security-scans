# terraform/Makefile

# ----------------------------------------------------------------
# Makefile Principal
# ----------------------------------------------------------------
include makefiles/config.mk
include makefiles/git.mk

# Cargar el archivo .env si existe
# Exporta todas las variables del .env al entorno de los comandos
ifneq ("$(wildcard .env)","")
    include .env
    export $(shell sed 's/=.*//' .env)
endif

.PHONY: help confirm
.DEFAULT_GOAL := help

# Definición de colores
YELLOW := \033[1;33m
GREEN  := \033[0;32m
CYAN   := \033[1;36m
RED    := \033[0;31m
RESET  := \033[0m

help:
	@echo "$(CYAN)Uso: make [comando]$(RESET)"
	@echo ""
	@echo "$(YELLOW)Git:$(RESET)"
	@echo "  git-s3-deploy          Git add, commit, push de root S3"
	@echo "  git-s3-module-deploy   Git add, commit, push del módulo S3"
	@echo ""

# ---