resource "aws_db_instance" "tesla_ce_database" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  multi_az             = false
  publicly_accessible  = true
  name                 = var.db_name
  username             = var.db_root_user
  password             = var.db_root_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  identifier           = "tesla-ce-database"
  db_subnet_group_name   = aws_db_subnet_group.tesla_ce_services.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  tags = {
    Name = "TeSLA CE Database"
  }
}

# Configure the MySQL provider based on the outcome of
# creating the aws_db_instance.
provider "mysql" {
  endpoint = aws_db_instance.tesla_ce_database.endpoint
  username = aws_db_instance.tesla_ce_database.username
  password = aws_db_instance.tesla_ce_database.password
}

# TeSLA CE database
resource "mysql_user" "tesla" {
  user               = var.db_user
  host               = "%"
  plaintext_password = var.db_password
  depends_on = [aws_db_instance.tesla_ce_database]
}

resource "mysql_grant" "tesla" {
  user       = mysql_user.tesla.user
  host       = mysql_user.tesla.host
  database   = aws_db_instance.tesla_ce_database.name
  privileges = ["ALL"]
  depends_on = [mysql_user.tesla]
}

# Vault database
resource "mysql_database" "vault" {
  name = var.vault_db_name
  depends_on = [aws_db_instance.tesla_ce_database]
}
resource "mysql_user" "vault" {
  user               = var.vault_db_user
  host               = "%"
  plaintext_password = var.vault_db_password
  depends_on = [mysql_database.vault]
}
resource "mysql_grant" "vault" {
  user       = mysql_user.vault.user
  host       = mysql_user.vault.host
  database   = mysql_database.vault.name
  privileges = ["ALL"]
  depends_on = [mysql_user.vault]
}

# Moodle database
resource "mysql_database" "moodle" {
  name = var.moodle_db_name
  depends_on = [aws_db_instance.tesla_ce_database]
}
resource "mysql_user" "moodle" {
  user               = var.moodle_db_user
  host               = "%"
  plaintext_password = var.db_password
  depends_on = [mysql_database.moodle]
}
resource "mysql_grant" "moodle" {
  user       = mysql_user.moodle.user
  host       = mysql_user.moodle.host
  database   = mysql_database.moodle.name
  privileges = ["ALL"]
  depends_on = [mysql_user.moodle]
}
