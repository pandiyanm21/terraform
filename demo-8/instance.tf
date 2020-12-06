# EC2 Instance
resource "aws_instance" "web" {
ami = var.AMIS[var.AWS_REGION]
instance_type = "t2.nano"

# VPC Subnet
subnet_id = aws_subnet.public-1A.id
vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}