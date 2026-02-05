# 🔒 AWS Secure IaC Lab ## Framework de Validación y Seguridad para Terraform

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

> 🚀 Reducir la superficie de ataque en la nube mediante la metodología Shift Left, integrando herramientas de análisis estático y validación de políticas que permitan detectar configuraciones riesgosas en el código de Terraform antes de la ejecución del apply.


## 🎯 Objetivos
- **Análisis Estático:** Detección de vulnerabilidades en el código fuente.
- **Validación del Plan:** Inspección del terraform plan para prevenir cambios riesgosos.
- **Cumplimiento (Compliance):** Verificación automática de políticas de seguridad.

---

## 🛡️ Escenarios de Seguridad y Alcance
El pipeline de validación inspecciona el código buscando mitigar los siguientes riesgos comunes en infraestructuras AWS:
- **Exposición de Datos:** Verificación de buckets S3 con acceso público, falta de cifrado (SSE) o ausencia de políticas de bloqueo de acceso público.
- **Gestión de Identidades (IAM):** Identificación de roles con privilegios excesivos (AdminAccess), uso de comodines (*) en políticas y falta de rotación de credenciales.
- **Seguridad de Red:** Detección de Security Groups con reglas de ingreso demasiado permisivas (ej. puertos 22 o 3389 abiertos a 0.0.0.0/0).
- **Cifrado y Secretos:** Escaneo de recursos (EBS, RDS, KMS) sin cifrado activo y detección de secretos (llaves de API, passwords) embebidos en el código.

---

## 🛠️ Herramientas de Inspección (Stack Tecnológico)
Para automatizar la detección de los riesgos anteriores, este repositorio utiliza un enfoque de defensa en capas dividido en dos fases:

### 1. Análisis Estático (Static Analysis)
Estas herramientas analizan el código fuente (.tf) sin necesidad de interactuar con AWS o generar un plan.
- **Checkov:** Framework de seguridad basado en políticas que escanea configuraciones en busca de fallos de seguridad y cumplimiento.
- **Tfsec:** Escáner de seguridad estático especializado en Terraform que utiliza un análisis basado en grafos para encontrar vulnerabilidades.

## 2. Análisis Dinámico del Plan (Plan Validation)
En esta fase se analiza el archivo binario generado por terraform plan para evaluar el impacto real de los cambios.
- **Terraform Compliance:** Herramienta que permite definir reglas de cumplimiento en lenguaje natural (Gherkin) para validar el estado deseado.
- **OPA (Open Policy Agent) / Rego:** (Opcional/Avanzado) Implementación de Policy-as-Code para definir guardrails personalizados antes del apply.

---



---