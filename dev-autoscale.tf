module "dev-autoscaling" {
  source = "./modules/autoscaling"
  _count = 1
  name = "cust01"
  image_id = "ami-0ec225b5e01ccb706" # amazon linux
  instance_type = "t2.micro"
  key_name = module.imank-ssh-public-key.key_name
  security_groups = ["${module.appserver-security-group.id}"]
  target_group_arns = ["${module.dev-elb.arn}"]
  user_data =<<EOM
#!/bin/bash
curl -O https://raw.githubusercontent.com/footprns/autoscale-tomcat/master/conf/install_salt.sh
sudo bash install_salt.sh
  EOM
  min_size = 1
  max_size = 2
  vpc_zone_identifier = ["subnet-445cac0c", "subnet-6b07b832", "subnet-cab073ac"] 
}

module "dev-elb" {
  source = "./modules/elb"
  name = "dev-elb"
  security_groups = ["${module.appserver-security-group.id}"]
}

/*
module "ami-dev-instance" {
  source = "./modules/create-ami"
  groupname = element(module.dev-autoscaling.id, 0)
  name = "dev-ami"
  _version = "v1.0.0"
}

output "debug" {
  value = module.dev-autoscaling.id
}
*/