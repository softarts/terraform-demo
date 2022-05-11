resource "aws_instance" "example" {
  ami                    = "ami-02a45d709a415958a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              python3 -m http.server 8080 &
              EOF

  tags = {
    Name = "terraform-example"
  }
}
