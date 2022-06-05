data "aws_region" "this" {}

data "aws_caller_identity" "this" {}

# data "aws_iam_role" "flow_logs" {
#   name = "system-flows-logs"
# }

resource "aws_vpc" "this" {    
    cidr_block           = var.cidr_block
    enable_dns_support   = var.enable_private_dns
    enable_dns_hostnames = var.enable_private_dns

    tags = {
        Name = var.name
    }
}

/*
When a VPC is created, a primary IPv4 CIDR block for the VPC must be specified. The aws_vpc_ipv4_cidr_block_association resource allows further IPv4 CIDR blocks to be added to the VPC.
*/
resource "aws_vpc_ipv4_cidr_block_association" "this" {    
    count = length(var.additional_cidr_blocks)
    cidr_block  = var.additional_cidr_blocks[count.index]
    vpc_id = aws_vpc.this.id
}

resource "aws_default_security_group" "this" {  
  vpc_id  = aws_vpc.this.id
  
  tags = {
    Name = "${var.name}-default"
  }  
}

resource "aws_default_network_acl" "this" {  
  default_network_acl_id = aws_vpc.this.default_network_acl_id
  ingress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  egress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  tags = {
    Name = "${var.name}-default"
  }

  lifecycle{
    ignore_changes = [subnet_ids]
  }
}

# resource "aws_flow_log" "this" {
#   iam_role_arn    = data.aws_iam_role.flow_logs.arn
#   log_destination = "arn:aws:logs:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:log-group:flow-log-${aws_vpc.this.id}"
#   traffic_type    = "ALL"
#   vpc_id          = aws_vpc.this.id
# }

// vpc endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.this.id
  service_name = "com.amazonaws.${data.aws_region.this.name}.s3"
  tags = {
    Name = "${var.name}-s3"
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id = aws_vpc.this.id
  service_name = "com.amazonaws.${data.aws_region.this.name}.dynamodb"
  tags = {
    Name = "${var.name}-dynamodb"
  }
}
// s3 & dynamodb
