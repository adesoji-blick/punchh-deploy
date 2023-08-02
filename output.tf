output "rds_hostname" {
  value     = aws_db_instance.punchh-mysql.address
  sensitive = true
}

output "rds_port" {
  value     = aws_db_instance.punchh-mysql.port
  sensitive = true
}

output "rds_username" {
  value     = aws_db_instance.punchh-mysql.username
  sensitive = true
}