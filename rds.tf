# Create RDS subnet group
resource "aws_db_subnet_group" "jonnie_db_subnet_group" {
    name = "jonnie-rds-subnet-group"
    subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]

    tags = {
        Name = "jonnie-rds-subnet-group"
    }
}

# Create RDS instance
resource "aws_db_instance" "jonnierds" {
    engine = "mysql"
    engine_version = "5.7"
    name = "jonnierds"
    instance_class = "db.t2.micro"
    allocated_storage = 20
    storage_type = "gp2"
    storage_encrypted = false
    identifier = "jonnie-rds"
    username = "rdsusername"
    password = "rdspassword"
    multi_az = false
    publicly_accessible = false

    vpc_security_group_ids = [aws_security_group.allow_ec2_mysql.id]
    db_subnet_group_name = aws_db_subnet_group.jonnie_db_subnet_group.name

    skip_final_snapshot = true
}

   

