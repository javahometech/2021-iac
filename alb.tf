resource "aws_lb_target_group" "myapp_tg" {
  name     = "myapp-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    protocol = "HTTP"
    path = "/index.html"
    port = 80
  }
}

# add targets to target group

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.myapp_tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}

# Application load balancer

resource "aws_lb" "myapp_alb" {
  name               = "myapp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = aws_subnet.public.*.id

  tags = {
    Environment = terraform.workspace
  }
}

# add listner to ALB

resource "aws_lb_listener" "webapp" {
  load_balancer_arn = aws_lb.myapp_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myapp_tg.arn
  }
}