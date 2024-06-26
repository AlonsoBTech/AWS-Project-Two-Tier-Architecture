### module/network/outputs.tf

output "vpc_id" {
  value = aws_vpc.project2_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_db_sub_grp.*.name
}

output "db_security_group" {
  value = [aws_security_group.project2_sg["db"].id]
}

output "public_sg" {
  value = [aws_security_group.project2_sg["webserver"].id]
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}