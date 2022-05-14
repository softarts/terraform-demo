resource "aws_instance" "example" {
  ami                    = "ami-02a45d709a415958a"
  instance_type          = "t2.micro"  

  tags = {
    Name = "terraform-example"
  }
}

