resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue" #roboshop-dev-catalogue
  port     = 8080
  protocol = "HTTP"
  vpc_id   = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
  deregistration_delay = 120
  health_check {
    healthy_threshold = 2
    interval = 5
    matcher = "200-299"
    path = "/health"
    port = 8080
    timeout = 2
    unhealthy_threshold = 3
  }
}



resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = nonsensitive([data.aws_ssm_parameter.catalogue_sg_id.value])
  subnet_id     = nonsensitive(split(",",data.aws_ssm_parameter.private_subnet_id.value)[0])

  tags = merge(local.common_tags,{
          Name = "${var.project}-${var.environment}-catalogue"
  })
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  
  provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
    ]
  }
}