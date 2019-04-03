variable "username" {}
variable "region" {}
variable "priv_key_path" {}
variable "pub_key" {}
variable "key_pair_name" {}

provider "aws" {
  region = "${var.region}"
}

resource "aws_key_pair" "deployer" {
  key_name = "${var.key_pair_name}"
  public_key = "${var.pub_key}"
}
resource "aws_default_vpc" "default" {

}
resource "aws_instance" "webhost" {
  ami           = "ami-090f10efc254eaf55"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.webhost.id}"]
  key_name = "${var.key_pair_name}"
  provisioner "salt-masterless" {
    "local_state_tree" = "./salt"
    "remote_state_tree" = "/srv/salt"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.priv_key_path)}"
    }
  }

}
resource "aws_security_group" "webhost" {
  name = "webhost"
  vpc_id = "${aws_default_vpc.default.id}"
  description = "Allow inbound traffic"
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = "ssh"
  }
  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = "http"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance-ip" {
  value = "${aws_instance.webhost.public_ip}"
}

output "key-pair-name" {
  value = "${aws_key_pair.deployer.key_name}"
}
