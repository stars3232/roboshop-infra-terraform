resource "aws_instance" "vpn" {
  ami           = data.aws_ami.openvpn.id
  instance_type = "t3.micro"
  vpc_security_group_ids = nonsensitive([data.aws_ssm_parameter.vpn_sg_id.value])
  subnet_id     = nonsensitive(split(",",data.aws_ssm_parameter.public_subnet_id.value)[0])
  key_name = "vpn-key"
  user_data = file("openvpn.sh")

  tags = merge(local.common_tags,{
          Name = "${var.project}-${var.environment}-vpn"
  })
}

resource "aws_route53_record" "vpn" {
  zone_id = var.zone_id
  name    = "vpn.sivarobots.shop"
  type    = "A"
  ttl     = 1
  records = [aws_instance.vpn.public_ip]
}
