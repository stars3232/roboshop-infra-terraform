data "aws_ssm_parameter" "vpc_id" {
  name = "/roboshop/dev/vpc_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/roboshop/dev/private_subnet_ids"
}

data "aws_ssm_parameter" "backend_alb_sg_id" {
  name  = "/roboshop/dev/backend_alb_sg_id"
}