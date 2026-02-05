# variables

variable "env" {
  description = "Entorno de despliegue (ej. sandbox, dev, prod). Se usa para nombrar recursos y cargar configuraciones específicas."
  type        = string
  default     = "sandbox"

  validation {
    condition     = contains(["sandbox", "dev", "prod"], var.env)
    error_message = "El entorno debe ser uno de los siguientes: sandbox, dev, prod."
  }
}

variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos del laboratorio."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado y organización."
  type        = string
  default     = "secure-iac-lab"
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos (Tags de seguimiento)."
  type        = map(string)
  default = {
    Env       = var.env
    ManagedBy = "Terraform"
    Project   = var.project_name
    Owner     = "CloudAutomationTeam"
  }
}

# ---