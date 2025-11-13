resource "aws_key_pair" "pub_key" {
  key_name   = "pub_key"
  public_key = file(var.key_path)
}
resource "aws_instance" "demo_instance" {
  availability_zone = "ap-south-1a"
  instance_type     = var.instancetype
  ami               = var.ami
  key_name          = aws_key_pair.pub_key.key_name
  subnet_id = aws_subnet.subnet_1.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  user_data = <<-EOF
                    sudo apt update -y
                    sudo apt install nginx
                    sudo systemctl start nginx 
                    sudo apt update -y 
                  EOF

    tags = {
      Name = "terraform_instance"
    }
}


resource "aws_eip" "eip" {
  instance = aws_instance.demo_instance.id

  tags = {
    Name = "elastic_ip_from_terraform"
  }
  
}
resource "aws_ebs_volume" "volume" {

  availability_zone = aws_instance.demo_instance.availability_zone
  size              = 3
  type              = "gp2"

  tags = {
    Name = "volume_for_instance"
  }

}

resource "aws_volume_attachment" "volume_attach" {
  instance_id  = aws_instance.demo_instance.id
  device_name  = "/dev/xvdf"
  volume_id    = aws_ebs_volume.volume.id
  force_detach = true


}

output "instance_name" {
  value = aws_instance.demo_instance.arn
}

output "name" {
  value = aws_instance.demo_instance.security_groups
}

output "ebs_name" {
  value = aws_ebs_volume.volume.id

}

output "eip" {

  value = aws_eip.eip.id
  
}

output "dns" {
  value = aws_instance.demo_instance.public_ip
}