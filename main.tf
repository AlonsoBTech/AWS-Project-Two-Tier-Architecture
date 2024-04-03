### root/main.tf

module "network" {
  source   = "./module/network"
  vpc_cidr = local.vpc_cidr
  # Settign the amount of public subnets to create
  public_sub_count = 2
  # Setting the amount of private subnets to create
  private_sub_count = 2
  # PublicSubnets will always have an even number IP for example 10.0.2.0/24
  public_subnet_cidr = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  # Privateubnets will always have a odd number IP for example 10.0.1.0/24
  private_subnet_cidr = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  security_groups     = local.security_groups
  db_subnet_group     = true
}

module "db" {
  source                  = "./module/db"
  db_identifier           = "project2db"
  db_storage              = 10
  db_engine               = "5.7"
  db_instance_class       = "db.t3.micro"
  db_parameter_group_name = "default.mysql5.7"
  db_subnet_group_name    = module.network.db_subnet_group_name[0]
  vpc_security_group_ids  = module.network.db_security_group
  dbname                  = var.dbname
  dbuser                  = var.dbuser
  dbpass                  = var.dbpass
  db_skip_snapshot        = true
}

module "alb" {
  source                  = "./module/alb"
  public_sg               = module.network.public_sg
  public_subnets          = module.network.public_subnets
  tg_port                 = 80
  tg_protocol             = "HTTP"
  vpc_id                  = module.network.vpc_id
  alb_healthy_threshold   = 2
  alb_unhealthy_threshold = 2
  alb_timeout             = 3
  alb_interval            = 30
  listener_port           = 80
  listener_protocol       = "HTTP"
}

module "ec2" {
  source          = "./module/ec2"
  instance_count  = 2
  instance_type   = "t2.micro"
  public_sg       = module.network.public_sg
  public_subnets  = module.network.public_subnets
  volume_size     = 10
  key_name        = "webkey"
  public_key_path = "~/.ssh/webkey.pub"
  # Setting the userdata path so it can be used without modification regardless of OS
  user_data_path     = file("${path.root}/userdata.sh")
  alb_target_grp_arn = module.alb.alb_target_grp_arn
  tg_port            = 80
}