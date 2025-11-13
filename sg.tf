resource "aws_security_group" "sg" {
  description = "this is demo Sg to allow http and ssh port"
  vpc_id = aws_vpc.vpc.id


  ingress {
    description = "alllow ssh "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "for http port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "terraform-created"
    Environment = "dev"
  }
}

output "sg_name" {
  value = aws_security_group.sg.id

}

output "sg_vpc_id" {
  value = aws_security_group.sg.vpc_id

}