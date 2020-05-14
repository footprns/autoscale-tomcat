variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "security_groups" {
  type = list
}
variable "name" {}
variable "get_password_data" {
  type = bool
}
variable "volume_type" {}




resource "aws_instance" "default" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = var.security_groups
  get_password_data = var.get_password_data
  root_block_device  {
      volume_type = var.volume_type
  }
  tags = {
    Name = "${var.name}"
  }
}

output "public_ip" {
  value = aws_instance.default.public_ip
}

output "password_data" {
  value = aws_instance.default.password_data
}
