resource "aws_instance" "webapp_server_azA" {
    ami = var.ami_id
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.webapp_sec_group.id}"]
    key_name = var.key_pair
    user_data = "${file("app-server1.sh")}"
    associate_public_ip_address = true
    subnet_id = "${aws_subnet.webapp_subnet[0].id}"
    availability_zone = var.availability_zones[0]

    tags = {
        Name = "webapp_server_azA"
    }
}

resource "aws_instance" "webapp_server_azB" {
    ami = var.ami_id
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.webapp_sec_group.id}"]
    key_name = var.key_pair
    user_data = "${file("app-server1.sh")}"
    associate_public_ip_address = true
    subnet_id = "${aws_subnet.webapp_subnet[1].id}"
    availability_zone = var.availability_zones[1]

    tags = {
        Name = "webapp_server_azB"
    }
}

resource "aws_instance" "database_server_azA" {
    ami = var.ami_id
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.database_sec_group.id}"]
    key_name = var.key_pair
    subnet_id = aws_subnet.database_subnet[0].id
    availability_zone = var.availability_zones[0]

    tags = {
        Name = "database_server_azA"
    }
}

resource "aws_instance" "database_server_azB" {
    ami = var.ami_id
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.database_sec_group.id}"]
    key_name = var.key_pair
    subnet_id = aws_subnet.database_subnet[1].id
    availability_zone = var.availability_zones[1]

    tags = {
        Name = "database_server_azB"
    }
}