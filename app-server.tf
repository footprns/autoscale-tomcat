module "appserver-security-group" {
  source = "./modules/security-group"
  name = "appserver-security-group"
  description = "Connection for App server"
  ingress_rules = [
  {
    description = "SSH from Intenet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["223.229.208.230/32"]
  },
  {
    description = "RDP from Intenet"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["223.229.208.230/32"]
  },
  {
    description = "Tomcat from Intenet"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "ALB from Intenet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ]

  egress_rules = [
  {
    description = "Traffic to Intenet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ]
}

/*
module "appserver" {
  source = "./modules/ec2"
  name = "appserver"
  ami = "ami-0ec225b5e01ccb706"
  instance_type = "t2.micro"
  key_name = module.imank-ssh-public-key.key_name
  security_groups = ["${module.appserver-security-group.name}"]
  associate_public_ip_address = false
  get_password_data = false
  volume_type = "standard" # magnetic 
}

output "appserver-public_ip" {
  value = module.appserver.public_ip
}
*/