resource "aws_instance" "bastion" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = nonsensitive([data.aws_ssm_parameter.bastion_sg_id.value])
  subnet_id     = nonsensitive(data.aws_ssm_parameter.public_subnet_id.value)

  tags = merge(local.common_tags,{
          Name = "${var.project}-${var.environment}-bastion"
  })
}