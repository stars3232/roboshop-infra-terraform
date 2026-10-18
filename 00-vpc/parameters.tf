resource "aws_ssm_parameter" "vpc_id" {
  name  = "/roboshop/dev/vpc_id"
  type  = "String"
  value = module.roboshop_vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_id" {
  name  = "/roboshop/dev/public_subnet_id"
  type  = "String"
  value = module.roboshop_vpc.public_subnet_id
}
