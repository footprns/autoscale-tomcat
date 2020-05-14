variable "name" {}
variable "security_groups" {
  type = list
}


resource "aws_lb" "default" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = ["subnet-cab073ac", "subnet-445cac0c", "subnet-6b07b832"]

  enable_deletion_protection = false

#   access_logs {
#     bucket  = "${aws_s3_bucket.lb_logs.bucket}"
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "${var.name}"
  }
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}

resource "aws_lb_target_group" "default" {
  name     = var.name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "vpc-4cc2dd2b"

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    protocol = "HTTP"
    port = "8080"
    path = "/"
    interval            = 30
    matcher = "200"
  }
}

output "arn" {
  value = aws_lb_target_group.default.arn
}
