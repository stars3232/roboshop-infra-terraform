resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/roboshop/dev/frontend_sg_id"
  type  = "String"
  value = module.frontend_sg.sg_id
}

resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/roboshop/dev/bastion_sg_id"
  type  = "String"
  value = module.bastion_sg.sg_id
}

resource "aws_ssm_parameter" "backend_alb_sg_id" {
  name  = "/roboshop/dev/backend_alb_sg_id"
  type  = "String"
  value = module.backend_alb_sg.sg_id
}

resource "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/roboshop/dev/vpn_sg_id"
  type  = "String"
  value = module.vpn_sg.sg_id
}

resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/roboshop/dev/mongodb_sg_id"
  type  = "String"
  value = module.mongodb_sg.sg_id
}

resource "aws_ssm_parameter" "redis_sg_id" {
  name  = "/roboshop/dev/redis_sg_id"
  type  = "String"
  value = module.redis_sg.sg_id
}

resource "aws_ssm_parameter" "rabbitmq_sg_id" {
  name  = "/roboshop/dev/rabbitmq_sg_id"
  type  = "String"
  value = module.rabbitmq_sg.sg_id
}

resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/roboshop/dev/mysql_sg_id"
  type  = "String"
  value = module.mysql_sg.sg_id
}

resource "aws_ssm_parameter" "catalogue_sg_id" {
  name  = "/roboshop/dev/catalogue_sg_id"
  type  = "String"
  value = module.catalogue_sg.sg_id
}