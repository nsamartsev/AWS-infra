variable "region" {
  type = string
  validation {
    condition     = var.region != ""
    error_message = "Region is empty."
  }
}

variable "instance_type" {
  type = string
  validation {
    condition     = var.instance_type != ""
    error_message = "Instance type variable is empty"
  }
}

variable "allow_ports" {
  description = "List of ports to open for server."
  type        = list(any)
}

variable "enable_detailed_monitoring" {
  type = bool
}