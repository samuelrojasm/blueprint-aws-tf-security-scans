# terraform/makefiles/config.mk

# -----------------------------------------------------------
# Definiciones de variables base
# Comandos Wrappers de Docker
# Definición de Targets (Tareas) de configuración base
# -----------------------------------------------------------

.PHONY: setup-cache

#-----------------------------
# Rutas de módulos de Makefile
#-----------------------------
S3_VULNERABLE_PATH = sandboxes/iac-security-scans/storage/s3-vulnerable
SG_VULNERABLE_PATH = sandboxes/iac-security-scans/network/sg-vulnerable
S3_MODULE_PATH = modules/storage/s3-vulnerable

#-------------------------------------------
# Variables del ProyecTO
#-------------------------------------------
GIT_BRANCH ?= main
GIT_MSG ?= "init: Initial commit"
GIT_FILE ?= README.md

TF_VERSION ?= 1.14.0
AWS_CLI_VERSION ?= 2.33.14

AWS_PROFILE ?= tf

AWS_REGION ?= us-east-1

#-----------------------------
# Definición de uso de Docker
#-----------------------------
# Definición de imágenes
AWS_IMAGE := amazon/aws-cli:$(AWS_CLI_VERSION)  # Versión fija para consistencia en el equipo
TF_IMAGE  := hashicorp/terraform:$(TF_VERSION)	

# Definición de comandos envolventes (Wrappers) de Docker
# Comandos base transparente (sin -it aquí para mayor flexibilidad)
 # Usamos = para que se evalúe justo al momento de usarla, no al cargar el archivo
DOCKER_AWS_CLI = docker run --rm -it \
	--user $(shell id -u):$(shell id -g) \
	--env HOME=/tmp \
    --volume $(HOME)/.aws:/tmp/.aws \
    --volume $(CURDIR):/aws \
    --workdir /aws \
    $(AWS_IMAGE)

# Comando de docker para ejecutar Terraform
#  Usamos = para que se evalúe justo al momento de usarla, no al cargar el archivo
# Inmutable, Seguro y con Caché
# 	1.- Plugin Cache: 						Evita que terraform init descargue gigabytes de datos en cada ejecución. Es una recomendación crítica de Hashicorp sobre el Plugin Cache.
# 	2.- Uso de --env TF_IN_AUTOMATION=true: Esto reduce el ruido visual en la terminal y optimiza la salida para logs de CI/CD, eliminando sugerencias interactivas innecesarias.
# 	3.- Cambio de /app a /src: 				Tendencia en Docker Hub para herramientas de infraestructura es usar /src o /workspace para diferenciar código fuente de binarios de aplicación.
#	4.- Flags Explícitos: 					Se prefiere --volume y --env en lugar de -v y -e en archivos de configuración para mejorar la legibilidad y evitar errores con herramientas de escaneo de seguridad (como Checkov o Terrascan).
# 	5. $(CURDIR) sobre $(PWD):				GNU Make recomienda CURDIR para garantizar que la ruta sea absoluta y evitar fallos en sistemas donde PWD no está exportado.
DOCKER_TF = docker run --rm \
    --user $(shell id -u):$(shell id -g) \
    --volume $(CURDIR):/src \
	--env HOME=/tmp \
	--env TF_VAR_aws_region=$(AWS_REGION) \
    --env TF_VAR_bucket_name=$(NAME_STATE_BUCKET) \
	--env AWS_PROFILE=$(AWS_PROFILE) \
    --env AWS_DEFAULT_REGION=$(AWS_REGION) \
    --env TF_IN_AUTOMATION=true \
    --env TF_PLUGIN_CACHE_DIR=/tmp/.terraform.d/plugin-cache \
    --volume $(HOME)/.aws:/tmp/.aws:ro \
	--volume $(CURDIR):/src \
    --volume terraform-plugin-cache:/tmp/.terraform.d/plugin-cache \
    --workdir /src \
    $(TF_IMAGE)

#-------------------------------
# Definición de Targets (Tareas)
#-------------------------------

setup-cache: ## Crea el volumen y ajusta permisos para el UID actual
	@docker volume create terraform-plugin-cache > /dev/null 2>&1
	@docker run --rm \
		--volume terraform-plugin-cache:/cache \
		alpine chown -R $(shell id -u):$(shell id -g) /cache
	@echo "✅ Volumen de caché listo con permisos para $(shell whoami)"

# ---
