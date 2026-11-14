module frontend_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "frontend"
    sg_description  = "security group for frontend component of roboshop"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}


module bastion_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "bastion"
    sg_description  = "security group for bastion instance"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}

module backend_alb_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "backend"
    sg_description  = "security group for backend_alb"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}

module vpn_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "vpn"
    sg_description  = "security group for vpn"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}

module mongodb_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "mongodb"
    sg_description  = "security group for mongodb"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}

module redis_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "redis"
    sg_description  = "security group for redis"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}

module rabbitmq_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "rabbitmq"
    sg_description  = "security group for rabbitmq"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}

module mysql_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "mysql"
    sg_description  = "security group for mysql"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}

module catalogue_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = var.project
    environment     = var.environment
    sg_name         = "catalogue"
    sg_description  = "security group for catalogue"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}



resource "aws_security_group_rule" "bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}

# sg rule to allow connections from bastion host to backend_alb. Instead of bastion ip, 
# v r using bastion sg_id
resource "aws_security_group_rule" "bastion_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id =  module.bastion_sg.sg_id
  security_group_id = module.backend_alb_sg.sg_id
}

#VPN Ports are 22,443,1194,943
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

# sg rule to allow connections from vpn to backend_alb. Instead of vpn ip, 
# v r using vpn sg_id
resource "aws_security_group_rule" "vpn_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id =  module.vpn_sg.sg_id
  security_group_id = module.backend_alb_sg.sg_id
}

resource "aws_security_group_rule" "vpn_mongodb" {
  count             = length(var.mongodb_ports)
  type              = "ingress"
  from_port         = var.mongodb_ports[count.index]
  to_port           = var.mongodb_ports[count.index]
  protocol          = "tcp"
  source_security_group_id =  module.vpn_sg.sg_id
  security_group_id = module.mongodb_sg.sg_id
}

resource "aws_security_group_rule" "vpn_redis" {
  count             = length(var.redis_ports)
  type              = "ingress"
  from_port         = var.redis_ports[count.index]
  to_port           = var.redis_ports[count.index]
  protocol          = "tcp"
  source_security_group_id =  module.vpn_sg.sg_id
  security_group_id = module.redis_sg.sg_id
}

resource "aws_security_group_rule" "vpn_rabbitmq" {
  count             = length(var.rabbitmq_ports)
  type              = "ingress"
  from_port         = var.rabbitmq_ports[count.index]
  to_port           = var.rabbitmq_ports[count.index]
  protocol          = "tcp"
  source_security_group_id =  module.vpn_sg.sg_id
  security_group_id = module.rabbitmq_sg.sg_id
}

resource "aws_security_group_rule" "vpn_mysql" {
  count             = length(var.rabbitmq_ports)
  type              = "ingress"
  from_port         = var.mysql_ports[count.index]
  to_port           = var.mysql_ports[count.index]
  protocol          = "tcp"
  source_security_group_id =  module.vpn_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "vpn_catalogue" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =  module.vpn_sg.sg_id
  security_group_id = module.catalogue_sg.sg_id
}

resource "aws_security_group_rule" "vpn_catalogue_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id =  module.vpn_sg.sg_id
  security_group_id = module.catalogue_sg.sg_id
}

# we should write a sg_rule to allow connections from bastion to catalogue on 22 & 8080 

resource "aws_security_group_rule" "catalogue_mongodb" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id =  module.catalogue_sg.sg_id
  security_group_id = module.mongodb_sg.sg_id
}


