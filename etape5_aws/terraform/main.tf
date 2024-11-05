provider "aws" {
  region = "us-east-1"  # Change la région si nécessaire
}

# Clé SSH pour accéder aux instances
resource "tls_private_key" "example_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer-key"
  public_key = tls_private_key.example_key.public_key_openssh
}

# Création d'un VPC et d'un sous-réseau
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Groupe de sécurité pour autoriser SSH, HTTP, et MySQL
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instance pour Nginx (HTTP)
resource "aws_instance" "nginx" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer_key.key_name
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "nginx-server"
  }
}

# Instance pour PHP-FPM (SCRIPT)
resource "aws_instance" "php_fpm" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer_key.key_name
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "php-fpm-server"
  }
}

# Instance pour MariaDB (DATA)
resource "aws_instance" "db" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer_key.key_name
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "db-server"
  }
}

