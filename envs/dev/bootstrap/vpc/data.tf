data "aws_availability_zones" "available" {
  state = "available"
}

#############################################
# Detect Current Public IP
#############################################

data "http" "my_public_ip" {
  url = "https://checkip.amazonaws.com/"
}