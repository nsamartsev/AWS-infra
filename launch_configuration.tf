resource "aws_launch_configuration" "web" {
  name_prefix     = "WebServer-Highly-Available-LC-"
  image_id        = data.aws_ami.amazon_linux_latest.id
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.webserver_security_group.id]
  user_data = templatefile("./utils/user_data.sh.tpl", {
    f_name = "Nikita",
    l_name = "Samartsev",
    names  = ["Vasya", "Petya"]
  })
}

resource "aws_autoscaling_group" "asg" {
  name                 = "ASG-${aws_launch_configuration.web.name}"
  launch_configuration = aws_launch_configuration.web.name
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier = [
    aws_default_subnet.default_eu1.id,
    aws_default_subnet.default_eu2.id
  ]
  health_check_type = "ELB"
  load_balancers    = [aws_elb.web_elb.name]

  dynamic "tag" {
    for_each = {
      Name  = "WebServer in ASG"
      Owner = "Nikita Samartsev"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "web_elb" {
  name = "WebServer-ha-elb"
  availability_zones = [
    data.aws_availability_zones.working.names[0],
    data.aws_availability_zones.working.names[1]
  ]
  security_groups = [aws_security_group.webserver_security_group.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "HTTP:80/"
    timeout             = 3
    unhealthy_threshold = 2
  }
  tags = {
    Name = "WebServer-Highly-Available-ELB"
  }
}

resource "aws_default_subnet" "default_eu1" {
  availability_zone = data.aws_availability_zones.working.names[0]
}

resource "aws_default_subnet" "default_eu2" {
  availability_zone = data.aws_availability_zones.working.names[1]
}

output "web_loadbalancer_url" {
  value = aws_elb.web_elb.dns_name
}