resource "aws_network_acl" "public_nacl" {
    vpc_id = aws_vpc.myCustomVPC.id
    subnet_ids = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]

  # Ingress rules
  # Allow all local traffic
    ingress {
        rule_no = "100"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        action = "allow"
        cidr_block = aws_vpc.myCustomVPC.cidr_block
    }

  # Allow HTTP local traffic to and from Port 80
    ingress {
        rule_no = "110"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

  # Allow SSH local traffic to and from Port 22
    ingress {
        rule_no = "120"
        protocol = "tcp"
        from_port = "22"
        to_port = "22"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

  # Allow HTTPS traffic from the internet
    ingress {
        rule_no = "130"
        protocol = "tcp"
        from_port = "443"
        to_port = "443"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    ingress {
        rule_no = "140"
        protocol = "tcp"
        from_port = "8080"
        to_port = "8080"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    # Allow the ephemeral ports from the internet
    ingress {
        rule_no = "150"
        protocol = "tcp"
        from_port = "1024"
        to_port = "65535"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    # Allow the ephemeral ports from the internet for UDP Protocol
    ingress {
        rule_no = "155"
        protocol = "17"
        from_port = "1024"
        to_port = "65535"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    ## Egress Rules
    ## Allow all ports, protocols, and IPs outbound
    egress {
        rule_no = "100"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    tags = {
        Name = "public_nacl"
    }
}

resource "aws_network_acl" "webapp_nacl" {
    vpc_id = aws_vpc.myCustomVPC.id
    subnet_ids = [aws_subnet.webapp_subnet[0].id, aws_subnet.webapp_subnet[1].id]

  # Ingress rules
  # Allow all local traffic
    ingress {
        rule_no = "100"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        action = "allow"
        cidr_block = aws_vpc.myCustomVPC.cidr_block
    }

  # Allow HTTP local traffic to and from Port 80
    ingress {
        rule_no = "110"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

  # Allow SSH local traffic to and from Port 22
    ingress {
        rule_no = "120"
        protocol = "tcp"
        from_port = "22"
        to_port = "22"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

  # Allow HTTPS traffic from the internet
    ingress {
        rule_no = "130"
        protocol = "tcp"
        from_port = "443"
        to_port = "443"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    ingress {
        rule_no = "140"
        protocol = "tcp"
        from_port = "8080"
        to_port = "8080"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    # Allow the ephemeral ports from the internet
    ingress {
        rule_no = "150"
        protocol = "tcp"
        from_port = "1024"
        to_port = "65535"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    # Allow the ephemeral ports from the internet for UDP Protocol
    ingress {
        rule_no = "155"
        protocol = "17"
        from_port = "1024"
        to_port = "65535"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    ## Egress Rules
    ## Allow all ports, protocols, and IPs outbound
    egress {
        rule_no = "100"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        action = "allow"
        cidr_block = var.allow_all_ip
    }

    tags = {
        Name = "webapp_nacl"
    }

}