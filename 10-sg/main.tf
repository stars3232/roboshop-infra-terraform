module roboshop_sg {
    source = "git::https://github.com/stars3232/terraform-aws-sg.git?ref=main"
    project         = "roboshop"
    environment     = "dev"
    sg_name         = "frontend"
    sg_description  = "security group for frontend component of roboshop"
    vpc_id          = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
}