resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP traffic only from internal network"
  vpc_id      = "vpc-12345678"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Ejemplo de rango interno
    description = "Allow HTTP from internal network"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"] # Limitar egress al mismo rango interno
    description = "Allow all traffic within internal network"
  }
}
