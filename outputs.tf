output "vpc_id" {
  value = aws_vpc.main.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "az_names" {
  value = data.aws_availability_zones.available.names
}
