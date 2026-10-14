module "roboshop_vpc" {
    #source        = "../terraform-vpc-module"
    source        = "git::https://github.com/stars3232/terraform-vpc-module.git?ref=main"
    cidr_block    = "10.0.0.0/16"
    project       = "Roboshop"
    environment   = "dev"
    public_subnet_cidr_blocks    = ["10.0.1.0/24","10.0.2.0/24"]
    private_subnet_cidr_blocks   = ["10.0.11.0/24","10.0.12.0/24"]
    database_subnet_cidr_blocks  = ["10.0.21.0/24","10.0.22.0/24"]
    is_peering_required          = true
}