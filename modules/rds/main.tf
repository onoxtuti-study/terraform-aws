resource "aws_db_instance" "rds_postgres" {
    identifier              = var.name
    db_name                 = "postgres"
    allocated_storage       = 20
    storage_type            = "gp3"
    engine                  = "postgres"
    engine_version          = "17.4"
    instance_class          = "db.t3.micro"
    db_subnet_group_name    = var.subnet
    username                = var.db_name
    password                = var.db_pass
    backup_retention_period = 0
    skip_final_snapshot     = true
    vpc_security_group_ids = [var.sg]

    tags = {
        Name = var.name
    }
}