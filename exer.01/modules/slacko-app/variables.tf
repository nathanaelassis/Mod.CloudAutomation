variable "subnet_cidr" {
    type = string
    default = "10.0.102.0/24"
}

variable "your_ssh_key" {
    type = string
}

variable "ami"{
    type = string
}

variable "vpc_id" {
    type = string
}

variable "prefix_name" {
    type = string
}

variable "tags" {
    default = {
        Faculdade = "Impacta"
        Modulo = "Cloud Automation"
    }
}

variable "instance_type_app" {
    type = string
    default = "t2.micro"
}

variable "instance_type_mongo" {
    type = string
    default = "t2.micro"
}