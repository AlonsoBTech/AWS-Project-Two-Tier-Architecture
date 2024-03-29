### root/locals.tf

locals {
  vpc_cidr = "10.0.0.0/16"
}

# This will be used to call host ip address so we don't have to input it in our code
locals {
  my_ip = jsondecode(data.http.my_public_ip.response_body)
}

# Setting our dynamic block for our network security group
locals {
  security_groups = {
    webserver = {
      name        = "webserver_sg"
      description = "WebServer Security Group"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = ["${local.my_ip.ip}/32"]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        https = {
          from        = 443
          to          = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
    db = {
      name        = "db_sg"
      description = "DB Security Group"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }
  }
}