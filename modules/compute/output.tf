output "alb_sg_id" {
  value = aws_security_group.alb_security_group.id
}

output "asg_sg_id" {
  value = aws_security_group.asg_security_group.id
}

output "alb_public_url" {
  description = "Public URL"
  value       = aws_lb.alb.dns_name
}