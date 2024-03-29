### module/ec2/main.tf

# Creating a random ID for each resource to tell them apart
# the use of tag names can also be used such as Server1 and Server2
# however with this in the event a change was made to our instance
# we can have it assigned a new ID so we know we are working with an
# updated web server instance.
resource "random_id" "project2_ec2_id" {
  byte_length = 2
  count       = var.instance_count
  keepers = {
    key_name = var.key_name
  }
}

# Creating SSH key
resource "aws_key_pair" "webserver_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)

  tags = {
    Name = "WebServer Key"
  }
}

# Creating Websever Instance
resource "aws_instance" "web_instance" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = var.public_sg
  subnet_id              = var.public_subnets[count.index]
  key_name               = aws_key_pair.webserver_key.id
  user_data              = var.user_data_path
  root_block_device {
    volume_size = var.volume_size
  }
  tags = {
    Name = "WebServer-${random_id.project2_ec2_id[count.index].dec}"
  }
}

# Creating ALB traget group attachment
resource "aws_lb_target_group_attachment" "project2_tg_attach" {
  count            = var.instance_count
  target_group_arn = var.alb_target_grp_arn
  target_id        = aws_instance.web_instance[count.index].id
  port             = var.tg_port
}