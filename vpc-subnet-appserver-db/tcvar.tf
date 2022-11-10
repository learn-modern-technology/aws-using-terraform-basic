# Declare or assign all variables here

variable "profile" {
    default = "learnssaws.profile"
}
variable "key_pair" {
    default = "ec2-autoscale-key"
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

variable "auto_assign_ip_subnet" {
    default = true
}

variable "public_subnet_cidr" {
    default = ["10.0.1.0/24","10.0.2.0/24"]
    type = list(string)
}

variable "private_subnet_cidr" {
    default = ["10.0.3.0/24","10.0.4.0/24"]
    type = list(string)
}

variable "ami_id" {
    default = "ami-090fa75af13c156b4"
} 