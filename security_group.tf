resource "aws_security_group" "webserver_security_group" {
  name        = "webserver security group"
  description = "my first security group"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # maybe in production, hard code
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server Security Group"
    Owner = "Nikita Samartsev"
  }
}