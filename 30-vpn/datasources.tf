data "aws_ami" "openvpn" {
  most_recent = true

  owners = ["444663524611"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/roboshop/dev/vpn_sg_id"
}

data "aws_ssm_parameter" "public_subnet_id" {
  name = "/roboshop/dev/public_subnet_ids"
}

