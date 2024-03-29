### ./module/alb/outputs.tf

output "alb_target_grp_arn" {
  value = aws_lb_target_group.project2_tg.arn
}

output "alb_endpoint" {
  value = aws_lb.project2_alb.dns_name
}