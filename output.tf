locals {
  zones_len = length(data.aws_availability_zones.working.names)
}

output "data_aws_availability_zone_names" {
  value = data.aws_availability_zones.working.names
}

# output last element using local variables
output "data_aws_availability_zone_names_last" {
  value = data.aws_availability_zones.working.names[local.zones_len - 1]
}

output "data_aws_availability_zones_zone_ids" {
  value = data.aws_availability_zones.working.zone_ids
}

output "data_aws_caller_identity" {
  value = [data.aws_caller_identity.current.user_id, data.aws_caller_identity.current.account_id]
}

output "data_aws_region" {
  value = [data.aws_region.current_region.name, data.aws_region.current_region.description]
}

output "data_aws_region_current_name" {
  value = data.aws_region.current_region.name
}