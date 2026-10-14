resource "aws_ssm_parameter" "vpc_id" {
  name  = "/robosho/dev/vpc_id"
  type  = "String"
  value = module.roboshop_vpc.vpc_id
}
