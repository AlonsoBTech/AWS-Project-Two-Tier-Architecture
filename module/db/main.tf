### module/db/main.tf

resource "aws_db_instance" "default" {
  identifier             = var.db_identifier
  allocated_storage      = var.db_storage
  db_name                = var.dbname
  engine                 = "mysql"
  engine_version         = var.db_engine
  instance_class         = var.db_instance_class
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = var.db_parameter_group_name
  skip_final_snapshot    = var.db_skip_snapshot

  tags = {
    Name = "Project2_DB"
  }
}