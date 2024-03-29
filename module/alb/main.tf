### module/alb/main.tf

# Creating Application Load Balancer (ALB)
resource "aws_lb" "project2_alb" {
  name               = "project2-alb"
  security_groups    = var.public_sg
  subnets            = var.public_subnets
  load_balancer_type = "application"
  idle_timeout       = 400

  tags = {
    Name = "Project2 ALB"
  }
}

# Creating ALB target group
resource "aws_lb_target_group" "project2_tg" {
  name     = "project2-alb-tg-${substr(uuid(), 0, 3)}"
  port     = var.tg_port     #80
  protocol = var.tg_protocol #HTTP
  vpc_id   = var.vpc_id
  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
  health_check {
    healthy_threshold   = var.alb_healthy_threshold   #2
    unhealthy_threshold = var.alb_unhealthy_threshold #2
    timeout             = var.alb_timeout             #3
    interval            = var.alb_interval            #30
  }
}

# Creating ALB listener 
resource "aws_lb_listener" "project2_listener" {
  load_balancer_arn = aws_lb.project2_alb.arn
  port              = var.listener_port     #80
  protocol          = var.listener_protocol #HTTP
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project2_tg.arn
  }

}
