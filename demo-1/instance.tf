resource "aws_instance" "web-server" {
  ami           = "${var.AMIS["${var.AWS_REGION}"]}"
  instance_type = "t2.micro"

  tags = {
    Name = "mycloudlms"
  }
}

hi
