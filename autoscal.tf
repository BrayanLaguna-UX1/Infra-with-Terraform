resource "aws_launch_template" "mytemplate" {
    
    instance_type = "t3.micro"
    vpc_security_group_ids = [ aws_security_group.Ec2websg.id ]
    image_id = data.aws_ami.amazon_id.id
    
    name_prefix = "Webservers"
    metadata_options {
      
    }
  
}


resource "aws_autoscaling_group" "MyautoSG" {
    name = "WebAutoScaling"
    min_size = 2
    max_size = 4

    vpc_zone_identifier = [ 
        aws_subnet.subnetpriv.id,
        aws_subnet.subnetpriv2.id
     ]

     target_group_arns = [ aws_alb_target_group.targetgp.arn ]
    health_check_type = "ELB"
    health_check_grace_period = 300
  
     mixed_instances_policy {
       launch_template {
         launch_template_specification {
           launch_template_id = aws_launch_template.mytemplate.id
           version = "$Latest"
         }
       }
       instances_distribution {
         on_demand_base_capacity = 2
         on_demand_percentage_above_base_capacity = 50

         spot_allocation_strategy = "capacity-optimized"
       }
     }
    
}

resource "aws_autoscaling_attachment" "autoscalingattach" {
    autoscaling_group_name = aws_autoscaling_group.MyautoSG.id
    lb_target_group_arn = aws_alb_target_group.targetgp.id
  
}