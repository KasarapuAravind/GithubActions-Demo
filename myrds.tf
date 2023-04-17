#rds
resource "aws_db_subnet_group" "my_sbnet_grp" {
  name       = "my subnet grp"
  subnet_ids = var.rds_subnets
}

resource "aws_db_instance" "my-sqlserver-rds" {
  allocated_storage      = 20
  engine                 = "sqlserver-ex"
  apply_immediately      = true
  engine_version         = "14.00.3381.3.v1"
  instance_class         = var.my_instance_class
  storage_type           = var.my_storage_type
  username               = "myuser"
  password = "MotherLove"
  db_subnet_group_name   = aws_db_subnet_group.my_sbnet_grp.name
  vpc_security_group_ids = [aws_security_group.my-sqlserver-rds-sg.id]
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = true
  deletion_protection    = true
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade  
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  timezone               = "UTC"
}

resource "aws_db_instance" "my-mysql-rds" {
  allocated_storage      = 40
  engine                 = "mysql"
  engine_version         = "5.7.38"
  apply_immediately      = true
  instance_class         = var.instance_class
  storage_type           = var.storage_type
  identifier             = "my-mysql-rds"
  username               = "myuser"
  password               = "MotherLove"
  db_subnet_group_name   = aws_db_subnet_group.my_sbnet_grp.name
  vpc_security_group_ids = [aws_security_group.my-mysql-rds-sg.id]
  publicly_accessible    = var.publicly_accessible
  parameter_group_name = aws_db_parameter_group.my-rds-pg.name
  skip_final_snapshot    = true
}

## RDS Parameter Group.
resource "aws_db_parameter_group" "my-rds-pg" {
  name   = "my-rds-pg"
  family = "mysql5.7"

  parameter {
    name  = "event_scheduler"
    value = "ON"
  }
}

resource "aws_db_snapshot" "testsnp" {
  db_instance_identifier = aws_db_instance.my-mysql-rds.id
  db_snapshot_identifier = "testsnapshot1234"
}

resource "aws_db_instance" "my-mysql-rds-copy" {
  instance_class      = "db.t2.micro"
  db_name                = "my-mysql-rds-copy"
  snapshot_identifier = data.aws_db_snapshot.testsnp.id

  lifecycle {
    ignore_changes = [snapshot_identifier]
  }
}