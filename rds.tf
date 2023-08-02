data "aws_availability_zones" "available" {}

resource "aws_db_instance" "punchh-mysql" {
  identifier             = "my-rds-mysql-db"
  engine                 = "mysql"
  instance_class         = "db.t2.micro"        # Change instance type if needed
  username               = "punchh_user"        # Replace with your desired username
  password               = "punchh_db_password" # Replace with your desired password
  allocated_storage      = 20                   # Change storage size if needed
  storage_type           = "gp2"
  multi_az               = false
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.punchh-db-sg.id] # Replace with your VPC security group ID

  # You can add more configurations like backup_retention_period, maintenance_window, etc. if needed.
}

resource "aws_security_group" "punchh-db-sg" {
  name_prefix = "punchh-rds-sg-"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this to specific IPs if desired for security reasons.
  }
}
