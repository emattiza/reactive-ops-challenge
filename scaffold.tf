variable "username" {}
variable "region" {}
variable "priv_key_path" {}

provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "webhost" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.webhost.id}"]
  key_name = "${var.username}"
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
