module "imank-ssh-public-key" {
  source = "./modules/key-pair"
  key_name = "imank-ssh-public-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "jumphost-security-group" {
  source = "./modules/security-group"
  name = "jumphost-security-group"
  description = "Allow ssh inbound traffic"
  ingress_rules = [
  {
    description = "SSH from Intenet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["182.70.42.83/32", "223.229.208.230/32"]
  },
  {
    description = "RDP from Intenet"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["182.70.42.83/32", "223.229.208.230/32"]
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


module "jumphost" {
  source = "./modules/ec2"
  name = "jumphost"
  ami = "ami-0ec225b5e01ccb706"
  instance_type = "t2.micro"
  key_name = module.imank-ssh-public-key.key_name
  security_groups = ["${module.jumphost-security-group.name}"]
  associate_public_ip_address = true
  get_password_data = false
  volume_type = "standard" # magnetic 
}

output "jumphost-public_ip" {
  value = module.jumphost.public_ip
}


