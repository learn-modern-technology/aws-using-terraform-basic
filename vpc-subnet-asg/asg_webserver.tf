resource "aws_autoscaling_group" "webapp_asg" {
  name = "Autoscaling-Webapp"
  max_size = 3
  min_size = 2
  #desired_capacity = 2
  health_check_grace_period  = 100
  health_check_type = "EC2"
  force_delete = true
  ##availability_zones = [var.availability_zones[0], var.availability_zones[1] ]
  vpc_zone_identifier = [aws_subnet.webapp_subnet[0].id, aws_subnet.webapp_subnet[1].id ]
  
  launch_template {
    id = aws_launch_template.template.id
    version = aws_launch_template.template.latest_version
  }

  termination_policies = [ "OldestInstance", "OldestLaunchConfiguration", "ClosestToNextInstanceHour", "OldestLaunchTemplate"]
  
  ##depends_on = [
  ##  aws_lb.webapp_lb
  ##]

  ##target_group_arns = [
  ##  aws_lb_target_group.webapp_tg.arn
  ##]

  lifecycle {
    create_before_destroy = true
  }

    tag {
      key = "Name"
      value = "ASG-ec2-instance"
      propagate_at_launch = true
    }
}

#define autoscaling configuration policy
resource "aws_autoscaling_policy" "cpu_policy" {
    name = "cpu_policy"
    autoscaling_group_name = aws_autoscaling_group.webapp_asg.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = 1
    cooldown = 60
    policy_type = "SimpleScaling"
}

# define autoscaling policy  to scale down
resource "aws_autoscaling_policy" "cpu_policy_scaledown" {
   name = "cpu_policy_scaledown"
   autoscaling_group_name = aws_autoscaling_group.webapp_asg.name
   adjustment_type = "ChangeInCapacity"
   scaling_adjustment = 1
   cooldown = 60
   policy_type = "SimpleScaling"
}
