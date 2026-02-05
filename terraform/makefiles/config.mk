# terraform/makefiles/config.mk

# -----------------------------------------------------------
# Definiciones de variables base
# Comandos Wrappers de Docker
# Definición de Targets (Tareas) de configuración base
# -----------------------------------------------------------

.PHONY: 

#-----------------------------
# Rutas de módulos de Makefile
#-----------------------------
S3_VULNERABLE_PATH = sandboxes/iac-security-scans/storage/s3-vulnerable
S3_MODULE_PATH = modules/storage/s3-vulnerable

#-------------------------------------------
# Variables del ProyecTO
#-------------------------------------------
GIT_BRANCH ?= main
GIT_MSG ?= "init: Initial commit"
GIT_FILE ?= README.md


# ---
