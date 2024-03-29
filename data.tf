### root/data.tf

# This will be used to call host ip address so we don't have to input it in our code
data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}
