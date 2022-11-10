resource "aws_route_table" "public_rt_tbl_azA" {
    vpc_id = aws_vpc.myCustomVPC.id

    route {
        cidr_block = var.allow_all_ip
        gateway_id = aws_internet_gateway.internet_gtw.id
    }

    tags = {
       Name = "public_rt_tbl_azA"
    }
}

resource "aws_route_table_association" "public_rt_tbl_azA_assoc" {
    route_table_id = aws_route_table.public_rt_tbl_azA.id
    subnet_id = aws_subnet.public_subnet[0].id
}

resource "aws_route_table" "webapp_rt_tbl_azA" {
    vpc_id = aws_vpc.myCustomVPC.id

    route {
        cidr_block = var.allow_all_ip
        nat_gateway_id = aws_nat_gateway.nat_gtw_azA.id
    }

    tags = {
        Name = "webapp_rt_tbl_azA"
    }
}

resource "aws_route_table_association" "webapp_rt_tbl_azA_assoc"{
    route_table_id = aws_route_table.webapp_rt_tbl_azA.id
    subnet_id = aws_subnet.webapp_subnet[0].id
}

resource "aws_route_table" "database_rt_tbl_azA" {
    vpc_id = aws_vpc.myCustomVPC.id

    route {
        cidr_block = var.allow_all_ip
        nat_gateway_id = aws_nat_gateway.nat_gtw_azA.id
    }

    tags = {
        Name = "database_rt_tbl_azA"
    }
}

resource "aws_route_table_association" "database_rt_tbl_azA_assoc" {
    route_table_id = aws_route_table.database_rt_tbl_azA.id
    subnet_id = aws_subnet.database_subnet[0].id
}

## Creating route table for Availability Zone B
resource "aws_route_table" "public_rt_tbl_azB" {
    vpc_id = aws_vpc.myCustomVPC.id

    route {
        cidr_block = var.allow_all_ip
        gateway_id = aws_internet_gateway.internet_gtw.id
    }

    tags = {
        Name = "public_rt_tbl_azB"
    }
}

resource "aws_route_table_association" "public_rt_tbl_azB_assoc" {
    route_table_id = aws_route_table.public_rt_tbl_azB.id
    subnet_id = aws_subnet.public_subnet[1].id
}

resource "aws_route_table" "webapp_rt_tbl_azB" {
    vpc_id = aws_vpc.myCustomVPC.id

    route {
        cidr_block = var.allow_all_ip
        gateway_id = aws_nat_gateway.nat_gtw_azB.id
    }
  
   tags = {
    Name = "webapp_rt_tbl_azB"
   }
}

resource "aws_route_table_association" "webapp_rt_tbl_azB_assoc" {
   route_table_id = aws_route_table.webapp_rt_tbl_azB.id
   subnet_id = aws_subnet.webapp_subnet[1].id
}

resource "aws_route_table" "database_rt_tbl_azB" {
   vpc_id = aws_vpc.myCustomVPC.id

    route {
        cidr_block = var.allow_all_ip
        gateway_id = aws_nat_gateway.nat_gtw_azB.id
    }

    tags = {
        Name = "database_rt_tbl_azB"
    }
}

resource "aws_route_table_association" "database_rt_tbl_azB_assoc" {
    route_table_id = aws_route_table.database_rt_tbl_azB.id
    subnet_id = aws_subnet.database_subnet[1].id
}
