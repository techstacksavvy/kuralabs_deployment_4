variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region= "us-east-2"

}

resource "aws_instance" "web_server01" {
  ami = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.web_ssh.id]

  user_data = "${file("deploy4.sh")}"

  tags = {
    "Name" : "Webserver001"
  }
  
}

resource "aws_instance" "web_server02" {
  ami = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"
  subnet_id = var.private_subnet
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.web_ssh.id]

  tags = {
    "Name" : "Webserver002"
  }
  
}

resource "aws_security_group" "web_ssh" {
  name = "ssh-access"
  description = "open ssh traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "Web-server-SG001"
    "Terraform" : "true"
  }

}

output "instance_ip" {
  value = aws_instance.web_server01.public_ip
}
