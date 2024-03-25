# Create RDS subnet group
resource "aws_db_subnet_group" "jonnie_db_subnet_group" {
  name       = "jonnie-rds-subnet-group"
  subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]

  tags = {
    Name = "jonnie-rds-subnet-group"
  }
}

# Create RDS instance
resource "aws_db_instance" "jonnie-rds" {
  engine              = "mysql"
  engine_version      = "8.0.28"
  name                = var.rds_name
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  storage_type        = "gp2"
  storage_encrypted   = false
  identifier          = "jonnie-rds"
  username            = var.rds_username
  password            = var.rds_password
  multi_az            = true
  publicly_accessible = true

  vpc_security_group_ids = [aws_security_group.allow_ec2_mysql.id]
  db_subnet_group_name   = aws_db_subnet_group.jonnie_db_subnet_group.name

  skip_final_snapshot = true
}

# Fetch RDS endpoint
data "aws_db_instance" "jonnie-rds" {
  db_instance_identifier = aws_db_instance.jonnie-rds.id
}