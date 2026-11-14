variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "mongodb_ports" {
    default = [22, 27017]
}

variable "redis_ports" {
    default = [22, 6379]
}

variable "rabbitmq_ports" {
    default = [22, 5672]
}

variable "mysql_ports" {
    default = [22, 3306]
}