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
  security_group_id = module.bastion_sg.sg_id
}