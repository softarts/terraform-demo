output "this_vpc_id" {  
  description = "ID of created VPC"
  value       = aws_vpc.this.id
}

output "this_vpc_cidr_blocks" {  
  description = "the CIRD blocks of the VPC"
  value       = concat([aws_vpc.this.cidr_block], aws_vpc_ipv4_cidr_block_association.this.*.cidr_block)
}

# output "default_route_table_id" {  
#   description = "default routing table ID"
#   value       = aws_vpc.this.default_route_table_id
# }

output "default_security_group_id" {  
  description = "default security group ID"
  value       = aws_default_security_group.this.id
}

output "default_network_acl_id" {  
  description = "default network ACL ID"
  value       = aws_default_network_acl.this.id
}

output "s3_vpc_endpoint_id" {  
  description = "s3 VPC endpoint ID"
  value       = aws_vpc_endpoint.s3
}

output "dynamodb_vpc_endpoint_id" {  
  description = "DynamoDB VPC endpoint ID"
  value       = aws_vpc_endpoint.dynamodb.id
}

