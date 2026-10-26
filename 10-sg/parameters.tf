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