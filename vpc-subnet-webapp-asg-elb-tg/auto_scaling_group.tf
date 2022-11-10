resource "aws_autoscaling_group" "webapp_asg" {
  name = "Autoscaling-Webapp"
  max_size = 6
  min_size = 1
  desired_capacity = 1
  health_check_grace_period  = 100
  health_check_type = "ELB"
  force_delete = true
  ##availability_zones = [var.availability_zones[0], var.availability_zones[1] ]
  vpc_zone_identifier = [aws_subnet.webapp_subnet[0].id, aws_subnet.webapp_subnet[1].id ]
  ##vpc_zone_identifier = ["subnet-0405c268361178e1c", "subnet-0bfc5d5fbe7f6d9e4" ]
  launch_template {
    id = aws_launch_template.template.id
    version = aws_launch_template.template.latest_version
  } 

  termination_policies = [ "OldestInstance", "OldestLaunchConfiguration", "ClosestToNextInstanceHour", "OldestLaunchTemplate"]
  
  depends_on = [
    aws_lb.webapp_lb
  ]

  target_group_arns = [
    aws_lb_target_group.webapp_tg.arn
  ]

  lifecycle {
    create_before_destroy = true
  }

}