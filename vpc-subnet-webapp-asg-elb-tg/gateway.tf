resource "aws_internet_gateway" "internet_gtw" {
    vpc_id = aws_vpc.myCustomVPC.id

    tags = {
        Name = "internet_gtw"
    }
}

## We can create multiple NAT Gateway in same AZ but it add costs and it is redundant
##The real reason for using multiple NAT Gateways is for high-availability.
##If there is a single NAT Gateway and that AZ should fail, 
##then all private instances would lose Internet access. Having a NAT Gateway in each AZ ensures high availability. 
##A NAT Gateway is redundant within a single AZ
## There will be data transfer charge between your NAT Gateway and EC2 instance if they are in the different availability zone
resource "aws_eip" "nat_gtw_eip_azA" {
    vpc = true
}

resource "aws_nat_gateway" "nat_gtw_azA" {
    subnet_id = aws_subnet.public_subnet[0].id
    connectivity_type = "public"
    allocation_id = aws_eip.nat_gtw_eip_azA.id

    depends_on = [aws_internet_gateway.internet_gtw]

    tags = {
        Name = "nat_gtw_azA"
    }
}

resource "aws_eip" "nat_gtw_eip_azB" {
    vpc = true
}

resource "aws_nat_gateway" "nat_gtw_azB" {
    subnet_id = aws_subnet.public_subnet[1].id
    connectivity_type = "public"
    allocation_id = aws_eip.nat_gtw_eip_azB.id

    depends_on = [ aws_internet_gateway.internet_gtw ]

    tags = {
        Name = "nat_gtw_azb"
    }
}