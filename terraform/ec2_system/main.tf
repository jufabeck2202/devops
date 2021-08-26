
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
  user_data     = <<-EOF
              #!/bin/bash
              echo "Tja der Beju ist jetzt cloud native" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "DNS" {
  value = aws_instance.example.public_dns
}
output "ip" {
  value = aws_instance.example.public_ip
}
