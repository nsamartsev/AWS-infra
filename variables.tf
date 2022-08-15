variable "region" {
  type = string
  validation {
    condition = var.region != ""
    error_message = "Region is empty."
  }
}