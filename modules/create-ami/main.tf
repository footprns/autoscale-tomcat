variable "groupname" {}
variable "name" {}
variable "_version" {}



data "aws_instances" "default" {
  instance_tags = {
    "aws:autoscaling:groupName"   = var.groupname
  }

#   filter {
#     name   = "instance.group-id"
#     values = ["sg-12345678"]
#   }

  instance_state_names = ["running", "stopped"]
}


output "debug" {
  value = data.aws_instances.default.ids
}

resource "aws_ami_from_instance" "default" {
  name               = var.name
  source_instance_id = element(data.aws_instances.default.ids, 0)
  tags = {
    version = var._version
  }
}