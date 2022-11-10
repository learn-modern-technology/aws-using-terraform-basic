# Configure aws provider
provider "aws" {
    profile = var.profile
    region = var.region
}

resource "aws_vpc" "myCustomVPC" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "myCustomVPC"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.myCustomVPC.id
    count = length(var.public_subnet_cidr)
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = var.auto_assign_ip_enable

    tags = {
        Name = "public_subnet"
    }
}

resource "aws_subnet" "webapp_subnet" {
    vpc_id = aws_vpc.myCustomVPC.id
    count = length(var.webapp_subnet_cidr)
    cidr_block = var.webapp_subnet_cidr[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = var.auto_assign_ip_disable

    tags = {
        Name = "webapp_subnet"
    }
}