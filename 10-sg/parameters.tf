resource "aws_ssm_parameter" "sg_id" {
  name  = "/roboshop/dev/sg_id"
  type  = "String"
  value = module.roboshop_sg.sg_id
}