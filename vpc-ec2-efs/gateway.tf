resource "aws_internet_gateway" "internet_gtw" {
    vpc_id = aws_vpc.myCustomVPC.id

    tags = {
        Name = "internet_gtw"
    }
}
