output "nginx_ip" {
  value = aws_instance.nginx.public_ip
}

output "php_fpm_ip" {
  value = aws_instance.php_fpm.public_ip
}

output "private_key" {
  value     = tls_private_key.example_key.private_key_pem
  sensitive = true
}

