locals {
    common_tags = {
                
                   Project = var.project
                   Environment = var.environment
                   Terraform = "true"
    }
    private_subnet_ids = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
}