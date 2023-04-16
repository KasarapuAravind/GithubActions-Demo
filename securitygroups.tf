resource "aws_security_group" "my-sqlserver-rds-sg" {
    name = "my-sqlserver-rds-sg"
    description = "myh sg for sql server rds"
    vpc_id = var.my_vpc_id
    tags = {
        Name = "aravind-infra"
    } 
}

resource "aws_security_group_rule" "allow_all_ingress_sqlserver" {
    type              = "ingress"
    from_port         = 0
    to_port           = 65535
    protocol          = "tcp"
    cidr_blocks       = [data.aws_vpc.mainvpc.cidr_block]
    security_group_id = aws_security_group.my-sqlserver-rds-sg.id
}

resource "aws_security_group_rule" "allow_all_egress_sqlserver" {
    type     = "egress"
    to_port  = 0
    protocol = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = 0
    security_group_id = aws_security_group.my-sqlserver-rds-sg.id
}

resource "aws_security_group" "my-mysql-rds-sg" {
    name        = "my-mysql-rds-sg"
    description = "my rds sg for mysql"
    vpc_id      = var.my_vpc_id
    lifecycle {
        ignore_changes = [tags, tags_all]
    }
}

resource "aws_security_group_rule" "allow_all_ingress_mysql" {
    type              = "ingress"
    from_port         = 0
    to_port           = 65535
    protocol          = "tcp"
    cidr_blocks       = [data.aws_vpc.mainvpc.cidr_block]
    security_group_id = aws_security_group.my-mysql-rds-sg.id
}

resource "aws_security_group_rule" "allow_all_egress_mysql" {
    type     = "egress"
    to_port  = 0
    protocol = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = 0
    security_group_id = aws_security_group.my-mysql-rds-sg.id
}