# Create an Launch template
resource "aws_launch_template" "template" {
    name                                 = "Terraform-launch-template"
    description                          = "Creating a launch template to implement auto scaled web application"
    image_id                             = var.ami_id
    instance_type                        = var.instance_type
    key_name                             = var.key_pair
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    instance_initiated_shutdown_behavior = "terminate"
    vpc_security_group_ids = ["${aws_security_group.webapp_sec_group.id}"]

    block_device_mappings {
      device_name = "/dev/xvda"
      ebs {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
        encrypted = false
        ##iops = 3000
        ##throughput = 500  ## maximum throughput can be 1000
        ##snapshot_id =  ## Can't be used when encrypted 
      }
    }

    #capacity_reservation_specification {
     # capacity_reservation_preference = none
      ##capacity_reservation_target =  ## Can be set when capacity reservation preference is open
    #}

    ##Can't be set for t2.micro instance type
    ##cpu_options {
    ##    core_count       = 4
    ##    threads_per_core = 2
    ##}   

    iam_instance_profile {
        name = "ec2-cloudwatchfullrole"
    }

    tag_specifications {
      resource_type = "instance"

      tags = {
        Name = "ASG-launch-template"
      }
    }

    user_data = "${filebase64("app-server1.sh")}"
}