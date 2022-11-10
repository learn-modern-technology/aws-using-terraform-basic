# Declare or assign all variables here

variable "profile" {
    default = "learnssaws.profile"
}
variable "key_pair" {
    default = "ec2-autoscale-key"
}

variable allow_all_ip {
    default = "0.0.0.0/0"
}

variable "availability_zones" {
    default = ["us-east-1a","us-east-1b"]
    type = list(string)
}
variable "region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "auto_assign_ip_enable" {
    default = true
}

variable "auto_assign_ip_disable" {
    default = false
}

variable "public_subnet_cidr" {
    default = ["10.0.10.0/24","10.0.20.0/24"]
    type = list(string)
}

variable "webapp_subnet_cidr" {
    default = ["10.0.11.0/24","10.0.21.0/24"]
    type = list(string)
}

variable "database_subnet_cidr" {
    default = ["10.0.12.0/24","10.0.22.0/24"]
    type = list(string)
}

variable "ami_id" {
    default = "ami-090fa75af13c156b4"
}

variable "instance_type" {
    default = "t2.micro"
}