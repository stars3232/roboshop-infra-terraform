resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = nonsensitive([data.aws_ssm_parameter.mongodb_sg_id.value])
  subnet_id     = nonsensitive(split(",",data.aws_ssm_parameter.database_subnet_id.value)[0])

  tags = merge(local.common_tags,{
          Name = "${var.project}-${var.environment}-mongodb"
  })
}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
    ]
  }
}

####################################################################################################

resource "aws_instance" "redis" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = nonsensitive([data.aws_ssm_parameter.redis_sg_id.value])
  subnet_id     = nonsensitive(split(",",data.aws_ssm_parameter.database_subnet_id.value)[0])

  tags = merge(local.common_tags,{
          Name = "${var.project}-${var.environment}-redis"
  })
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
    ]
  }
}

#######################################################################################################

resource "aws_instance" "rabbitmq" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = nonsensitive([data.aws_ssm_parameter.rabbitmq_sg_id.value])
  subnet_id     = nonsensitive(split(",",data.aws_ssm_parameter.database_subnet_id.value)[0])

  tags = merge(local.common_tags,{
          Name = "${var.project}-${var.environment}-rabbitmq"
  })
}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install ansible -y"
      ]
  }
}

####################################################################################################

resource "aws_instance" "mysql" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = nonsensitive([data.aws_ssm_parameter.mysql_sg_id.value])
  subnet_id     = nonsensitive(split(",",data.aws_ssm_parameter.database_subnet_id.value)[0])
  iam_instance_profile = "awsRoleToFetchMysqlPasswordFromSSMParameter"

  tags = merge(local.common_tags,{
          Name = "${var.project}-${var.environment}-mysql"
  })
}

resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
    ]
  }
}

resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "mongodb-${var.environment}.sivarobots.shop"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
}

resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name    = "redis-${var.environment}.sivarobots.shop"
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name    = "rabbitmq-${var.environment}.sivarobots.shop"
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
}

resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.sivarobots.shop"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
}