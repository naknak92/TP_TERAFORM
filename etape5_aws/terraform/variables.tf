variable "aws_access_key" {
  description = "Votre clé d'accès AWS"
}

variable "aws_secret_key" {
  description = "Votre clé secrète AWS"
}

variable "instance_type" {
  description = "Type d'instance EC2 à utiliser"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID pour l'instance (utilise une AMI Amazon Linux 2 compatible)"
  default     = "ami-0c55b159cbfafe1f0"  # Remplace par une AMI compatible dans ta région
}

