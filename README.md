# 🔒 AWS Secure IaC Lab 
## Framework de Validación y Seguridad para Terraform

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

## 🛡️ Escenarios de seguridad y alcance
El pipeline de validación inspecciona el código buscando mitigar los siguientes riesgos comunes en infraestructuras AWS:
- **Exposición de Datos:** Verificación de buckets S3 con acceso público, falta de cifrado (SSE) o ausencia de políticas de bloqueo de acceso público.
- **Gestión de Identidades (IAM):** Identificación de roles con privilegios excesivos (AdminAccess), uso de comodines (*) en políticas y falta de rotación de credenciales.
- **Seguridad de Red:** Detección de Security Groups con reglas de ingreso demasiado permisivas (ej. puertos 22 o 3389 abiertos a 0.0.0.0/0).
- **Cifrado y Secretos:** Escaneo de recursos (EBS, RDS, KMS) sin cifrado activo y detección de secretos (llaves de API, passwords) embebidos en el código.

---

## 🛠️ Herramientas de inspección (Stack Tecnológico)
Para automatizar la detección de los riesgos anteriores, este repositorio utiliza un enfoque de defensa en capas dividido en dos fases:

### 1. Análisis estático (Static Analysis)
Estas herramientas analizan el código fuente (.tf) sin necesidad de interactuar con AWS o generar un plan.
- **Checkov:** Framework de seguridad basado en políticas que escanea configuraciones en busca de fallos de seguridad y cumplimiento.
- **Tfsec:** Escáner de seguridad estático especializado en Terraform que utiliza un análisis basado en grafos para encontrar vulnerabilidades.

### 2. Análisis Dinámico del Plan (Plan Validation)
En esta fase se analiza el archivo binario generado por terraform plan para evaluar el impacto real de los cambios.
- **Terraform Compliance:** Herramienta que permite definir reglas de cumplimiento en lenguaje natural (Gherkin) para validar el estado deseado.
- **OPA (Open Policy Agent) / Rego:** (Opcional/Avanzado) Implementación de Policy-as-Code para definir guardrails personalizados antes del apply.

---

## 🔄 Ciclo de Vida de una Prueba (Workflow)
Para garantizar la integridad de la infraestructura en AWS, cada cambio sigue un ciclo de vida de validación estricto. Este proceso asegura que ninguna configuración vulnerable llegue a ser desplegada, incluso en nuestro entorno de pruebas.
### El flujo se divide en cuatro etapas principales:
1. Inicialización y Selección de Entorno
Se prepara el espacio de trabajo y se define el entorno mediante variables de entorno. En este laboratorio, priorizamos el aislamiento total.
    - Acción:
        ```bash
        terraform init
        ```
2. Análisis Estático de Código (SAST)
Antes de generar cualquier plan, las herramientas de escaneo (Checkov y Tfsec) analizan los archivos .tf.
    - **Objetivo:** Detectar errores de sintaxis, secretos expuestos o configuraciones inseguras "por diseño".
    - **Resultado:** Si se detecta una vulnerabilidad crítica, el proceso se detiene automáticamente (Fail-Fast).

3. Generación y Validación del Plan (Pre-Apply)
Se crea un artefacto binario (tfplan) que representa exactamente qué recursos se crearán o modificarán en AWS.
    - Acción:
        ```bash
        terraform plan -out=tfplan
        ```
    - **Validación:** Se utiliza Terraform Compliance o OPA para interrogar al plan. Aquí es donde el análisis basado en grafos confirma que las relaciones entre recursos (ej. VPC -> Security Group -> EC2) son seguras.

4. Ejecución Controlada (Apply)
Solo cuando todas las capas de seguridad anteriores han devuelto una señal de "éxito", se procede a la creación de recursos.
    - Acción: 
        ```bash
        terraform apply "tfplan"
        ```
    - **Verificación Post-Despliegue:** (Opcional) Escaneo del entorno en tiempo real para confirmar que la postura de seguridad se mantiene.

> [!NOTE]
> Este flujo implementa el concepto de Guardrails de Seguridad. En lugar de corregir errores después de que la infraestructura existe, este repositorio obliga a que la seguridad sea un requisito para el despliegue.

🚀 Guía de Ejecución Rápida
Pasos para validar y desplegar la infraestructura de forma segura

1. Preparación del Entorno
Configura tu variable de entorno y prepara el backend de Terraform:

---