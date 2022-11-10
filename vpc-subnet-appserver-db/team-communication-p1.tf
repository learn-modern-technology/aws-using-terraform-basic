# Configure aws provider
provider "aws" {
    profile = "${var.profile}"
    region = "${var.region}"
}

resource "aws_vpc" "teamcomm-vpc" {
    cidr_block = "${var.vpc_cidr}"

    tags = {
        Name = "Team-Communication-VPC"
    }
}

resource "aws_subnet" "public-subnet" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"
    ##count = "${length(var.public_subnet_cidr)}"
    cidr_block = "${var.public_subnet_cidr[0]}"
    availability_zone = "${var.availability_zones[0]}"
    map_public_ip_on_launch = "${var.auto_assign_ip_subnet}"
    tags = {
        Name = "Public-Subnet"
    }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"
    ##count = "${length(var.private_subnet_cidr)}"
    cidr_block = "${var.private_subnet_cidr[1]}"
    availability_zone = "${var.availability_zones[1]}"

    tags ={
        Name = "Private-Subnet"
    }
}

resource "aws_network_acl" "team-pub-nacl" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"
    subnet_ids = ["${aws_subnet.public-subnet.id}"]

    ingress {
        rule_no = "100"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    ingress {
        rule_no = "110"
        protocol = "tcp"
        from_port = "1024"
        to_port = "65535"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    ingress {
        rule_no = "120"
        protocol = "tcp"
        from_port = "22"
        to_port = "22"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    ingress {
        rule_no = "130"
        protocol = "tcp"
        from_port = "443"
        to_port = "443"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    ingress {
        rule_no = "140"
        protocol = "tcp"
        from_port = "8080"
        to_port = "8080"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    egress {
        rule_no = "100"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        rule_no ="110"
        protocol = "tcp"
        from_port = "1024"
        to_port = "65535"
        action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        rule_no = "120"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        rule_no = "130"
        protocol = "tcp"
        from_port = "443"
        to_port = "443"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    egress {
        rule_no = "140"
        protocol = "tcp"
        from_port = "8080"
        to_port = "8080"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }
}

resource "aws_network_acl" "team-priv-nacl" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"
    subnet_ids = ["${aws_subnet.private-subnet.id}"]

    ingress {
        rule_no = "100"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    ingress {
        rule_no = "110"
        protocol = "tcp"
        from_port = "1024"
        to_port = "65535"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    ingress {
        rule_no = "120"
        protocol = "tcp"
        from_port = "22"
        to_port = "22"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    ingress {
        rule_no = "130"
        protocol = "tcp"
        from_port = "443"
        to_port = "443"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    ingress {
        rule_no = "140"
        protocol = "tcp"
        from_port = "8080"
        to_port = "8080"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    egress {
        rule_no = "100"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        rule_no ="110"
        protocol = "tcp"
        from_port = "1024"
        to_port = "65535"
        action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        rule_no = "120"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        rule_no = "130"
        protocol = "tcp"
        from_port = "443"
        to_port = "443"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }

    egress {
        rule_no = "140"
        protocol = "tcp"
        from_port = "8080"
        to_port = "8080"
        action = "allow"
        cidr_block = "0.0.0.0/0"

    }
}


resource "aws_internet_gateway" "teamcomm-vpc-igw" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"

    tags = {
        Name = "Team-Communication-VPC-IGW"
    }
}

resource "aws_route_table" "pub-route-table" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.teamcomm-vpc-igw.id}"
    }

 tags = {
    Name = "Public-Route-Table"
 }
}

resource "aws_route_table_association" "pub-route-assoc" {
    route_table_id = "${aws_route_table.pub-route-table.id}"
    subnet_id = "${aws_subnet.public-subnet.id}"
}

resource "aws_eip" "nat-gateway-eip" {
    vpc = true
}

resource "aws_nat_gateway" "teamcomm-nat-gateway" {
    subnet_id = "${aws_subnet.public-subnet.id}"
    connectivity_type = "public"
    allocation_id = "${aws_eip.nat-gateway-eip.id}"

    depends_on = [aws_internet_gateway.teamcomm-vpc-igw]

    tags = {
        Name = "teamcomm-nat-gateway"
    }
}

resource "aws_route_table" "private-route-table" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.teamcomm-nat-gateway.id}"
    }

    tags = {
        Name = "private-route-table"
    }
}

resource "aws_route_table_association" "private-route-assoc" {
    route_table_id = "${aws_route_table.private-route-table.id}"
    subnet_id = "${aws_subnet.private-subnet.id}"
}

resource "aws_security_group" "App-Server-SG" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"
    name = "App-server-SG"
    description = "Security Group for App Server"

    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "8080"
        to_port = "8080"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "8065"
        to_port = "8065"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "DB-Server-SG" {
    vpc_id = "${aws_vpc.teamcomm-vpc.id}"
    name = "DB-server-SG"
    description = "Security Group for DB Server"

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

     egress {
        from_port = "22"
        to_port = "22"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "80"
        to_port = "80"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "App-Server" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.App-Server-SG.id}"]
    key_name = "${var.key_pair}"
    user_data = "${file("app-server1.sh")}"
    subnet_id = "${aws_subnet.public-subnet.id}"
    availability_zone = "${var.availability_zones[0]}"

    tags = {
        Name = "App-Server"
    }
}

resource "aws_instance" "DB-Server" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.DB-Server-SG.id}"]
    key_name = "${var.key_pair}"
    subnet_id = "${aws_subnet.private-subnet.id}"
    availability_zone = "${var.availability_zones[1]}"

    tags = {
        Name = "DB-Server"
    }

}