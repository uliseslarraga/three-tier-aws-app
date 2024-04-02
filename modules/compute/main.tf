resource "aws_launch_template" "web_app_lt" {
  name = "web-app-launch-temp"
  image_id = data.aws_ami.web_app_image.id
  instance_type = var.instance_type
  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_security_group.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = merge({Name = "web-app-instance"}, var.tags)
  }
  user_data = filebase64("${path.module}/scripts/init.sh")
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [for i in var.private_subnets[*] : i]
  target_group_arns   = [aws_lb_target_group.target_group.arn]

  launch_template {
    id      = aws_launch_template.web_app_lt.id
    version = aws_launch_template.web_app_lt.latest_version
  }
}