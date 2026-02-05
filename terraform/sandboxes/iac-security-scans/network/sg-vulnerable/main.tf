# main.tf

# Ejemplo de red insegura para activar alertas de Checkov
resource "aws_security_group" "insecure_sg" {
  name        = "insecure-sg"
  description = "Security group con reglas de entrada peligrosas"

  # INSEGURO: Permite SSH desde cualquier parte del mundo
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # INSEGURO: Permite RDP (Escritorio remoto) abierto a todos
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # INSEGURO: Tráfico de salida sin restricciones
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---