resource "aws_lb" "webapp_lb" {
  name = "webapp-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb_security_group.id]
  subnets = [ for subnet in aws_subnet.public_subnet : subnet.id ]

    tags = {
        Name="webapp_lb"
    }
}

resource "aws_lb_target_group" "webapp_tg" {
    name = "webapp-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.myCustomVPC.id
    target_type = "instance"

    health_check {
        enabled = true
        interval = 120
        healthy_threshold = 10
        timeout = 30
        port = 80
        unhealthy_threshold = 10
        path = "/health"
    }

    tags = {
        Name = "webapp_tg"
    }
}

##Actually giving seperate tag (name) for aws_alb_target_group_attachment 
## will help to add multiple target instances inside one taget group
resource "aws_lb_target_group_attachment" "webapp_tg_attach_azA" {
    target_group_arn = aws_lb_target_group.webapp_tg.arn
    target_id = aws_instance.webapp_server_azA.id  
}

resource "aws_lb_target_group_attachment" "webapp_tg_attach_azB" {
    target_group_arn = aws_lb_target_group.webapp_tg.arn
    target_id = aws_instance.webapp_server_azB.id
}

resource "aws_lb_listener" "webapp_lb_listner" {
    load_balancer_arn = aws_lb.webapp_lb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp_tg.arn
  }
}