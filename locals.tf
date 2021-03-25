locals {
  num_of_subnets = length(data.aws_availability_zones.available.names)
  ws = terraform.workspace
}