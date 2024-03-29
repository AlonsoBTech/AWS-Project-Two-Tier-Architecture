### module/network/main.tf

# Creating VPC
resource "aws_vpc" "project2_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Project2-VPC"
  }
}

# Creating Public Subnets for VPC
resource "aws_subnet" "public_subnet" {
  count                   = var.public_sub_count
  vpc_id                  = aws_vpc.project2_vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true


  tags = {
    Name = "Public-Subnet_${count.index + 1}"
  }
}

# Creating Private Subnets for VPC
resource "aws_subnet" "private_subnet" {
  count                   = var.private_sub_count
  vpc_id                  = aws_vpc.project2_vpc.id
  cidr_block              = var.private_subnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false


  tags = {
    Name = "Private-Subnet_${count.index + 1}"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "project2_igw" {
  vpc_id = aws_vpc.project2_vpc.id

  tags = {
    Name = "Project2-IGW"
  }
}

# Creating Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.project2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project2_igw.id
  }

  tags = {
    Name = "PublicRT"
  }
}

# Creating Public Route Table Associations
resource "aws_route_table_association" "public_rt_asso" {
  count          = var.public_sub_count
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_rt.id
}

# Creating Security Groups
resource "aws_security_group" "project2_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.project2_vpc.id
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating Database Subnet Group
resource "aws_db_subnet_group" "rds_db_sub_grp" {
  count      = var.db_subnet_group == true ? 1 : 0
  name       = "rds_db_sub_grp"
  subnet_ids = aws_subnet.private_subnet.*.id

  tags = {
    Name = "My DB subnet group"
  }
}