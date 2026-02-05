# variables

variable "bucket_name" {
  description = "Nombre del Bucket"
  type        = string
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos (Tags de seguimiento)."
  type        = map(string)
}