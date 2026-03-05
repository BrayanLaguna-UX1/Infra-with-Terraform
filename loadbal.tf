resource "aws_alb" "my_alb" {
    name = "Alb_main"
    subnets = [ aws_subnet.subnetpriv.id, aws_subnet.subnetpriv2.id ]
    security_groups = [ aws_security_group.albsg.id ]
    load_balancer_type = "application"
    
    access_logs {
      bucket = aws_s3_bucket.mys3.id
      enabled = true
      prefix = "Alb_main_log"
    }
}

resource "aws_alb_target_group" "targetgp" {
    name = "target-Gp"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.myvpc.id

    target_group_health {
      dns_failover {
        minimum_healthy_targets_count = 1
        minimum_healthy_targets_percentage = "off"
      }
      unhealthy_state_routing {
        minimum_healthy_targets_count = 1
        minimum_healthy_targets_percentage = "off"
      }
    }
    health_check {
      path = "/"
      protocol = "HTTP"
      interval = 30
      timeout = 5
      matcher = "200"
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
  
}

resource "aws_alb_target_group_attachment" "mytarget_GP" {
    target_group_arn = aws_alb_target_group.targetgp.arn
    for_each = { 
        server1 = aws_instance.web_server.id,
        serve2 = aws_instance.web_server2.id}
    target_id = each.value
    port = 80 
}

resource "aws_alb_listener" "listener1" {
  load_balancer_arn = aws_alb.my_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.targetgp.arn
    type = "forward"
  }
  
}

