resource "aws_instance" "my_instance" {
  ami             = "ami-06dd92ecc74fdfb36"
  instance_type   = "t2.micro"
  key_name        = "stephan"
  count           = 2
  security_groups = [aws_security_group.my_security_group.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt upgrade -y
              sudo apt install ansible -y
              EOF

  tags = {
    Name = "Ubuntu"
  }
}

resource "aws_instance" "my_instance_amazon" {
  ami             = "ami-0669b163befffbdfc"
  instance_type   = "t2.micro"
  key_name        = "stephan"
  security_groups = [aws_security_group.my_security_group.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum upgrade -y
              sudo yum install ansible -y
              EOF

  tags = {
    Name = "Amazon Linux 3"
  }
}


resource "aws_security_group" "my_security_group" {
  name_prefix = "my-sg-"

  # Fully public inbound rules for SSH, HTTP, and HTTPS.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
  }

  # Fully public outbound rules.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all outbound traffic"
  }

  tags = {
    Name = "Ansible1SecurityGroup"
  }
}
