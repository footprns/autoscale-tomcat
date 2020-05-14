module "dev-autoscaling" {
  source = "./modules/autoscaling"
  _count = 0
  name = "cust01"
  image_id = "ami-0ec225b5e01ccb706" # amazon linux
  instance_type = "t2.micro"
  key_name = module.imank-ssh-public-key.key_name
  security_groups = ["${module.appserver-security-group.id}"]
  min_size = 1
  max_size = 2
  vpc_zone_identifier = ["subnet-445cac0c", "subnet-6b07b832", "subnet-cab073ac"] 
}