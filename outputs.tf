# Outputs

# Output RDS Endpoint
# output "rds_endpoint" {
  # value = data.aws_db_instance.jonnie-rds.endpoint
# }

# Output RDS Name
output "rds_name" {
  value = var.rds_name
}

# Output RDS Username
output "rds_username" {
  value = var.rds_username
}

# Output RDS Password
output "rds_password" {
  sensitive = true
  value     = var.rds_password
}

# Output Root Password
output "rds_rootpassword" {
  sensitive = true
  value     = var.rds_rootpassword
}

