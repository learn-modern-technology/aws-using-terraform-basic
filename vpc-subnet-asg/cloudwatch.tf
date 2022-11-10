# define scaling cloudwatch
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
    alarm_name = "cpu_alarm_scaledown"
    alarm_description = "alarm once cpu usage decreases"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 10

    dimensions = {
        "AutoScalingGroupName": aws_autoscaling_group.webapp_asg.name
    }

    actions_enabled = true
    alarm_actions = [aws_autoscaling_policy.cpu_policy.arn]
}

#define de-scaling cloudwatch
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scaledown" {
  alarm_name = "cpu_alarm_scaledown"
  alarm_description = "alarm once cpu usage decreases"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 120
  statistic = "Average"
  threshold = 10

  dimensions = {
    "AutoScalingGroupName": aws_autoscaling_group.webapp_asg.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.cpu_policy_scaledown.arn]
}