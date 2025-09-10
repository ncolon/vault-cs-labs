# variable "friendly_name_prefix" {
#   type = string
# }

# variable "health_check_interval" {
#   type        = number
#   description = "Approximate amount of time, in seconds, between health checks of an individual target. The range is 5-300."
#   default     = 5

#   validation {
#     condition     = var.health_check_interval >= 5 && var.health_check_interval <= 300
#     error_message = "The health check interval must be between 5 and 300."
#   }
# }

# variable "health_check_timeout" {
#   type        = number
#   description = "Amount of time, in seconds, during which no response from a target means a failed health check. The range is 2–120 seconds."
#   default     = 3

#   validation {
#     condition     = var.health_check_timeout >= 2 && var.health_check_timeout <= 120
#     error_message = "The health check timeout must be between 2 and 120."
#   }
# }

# variable "health_check_deregistration_delay" {
#   type        = number
#   description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds."
#   default     = 15

#   validation {
#     condition     = var.health_check_deregistration_delay >= 0 && var.health_check_deregistration_delay <= 3600
#     error_message = "The health check deregistration delay must be between 0 and 3600."
#   }
# }

# variable "stickiness_enabled" {
#   type        = bool
#   description = "Enable sticky sessions by client IP address for the load balancer."
#   default     = true
# }

# variable "load_balancing_scheme" {
#   type        = string
#   description = "Type of load balancer to use (INTERNAL, EXTERNAL, or NONE)"
#   default     = "INTERNAL"

#   validation {
#     condition     = var.load_balancing_scheme == "INTERNAL" || var.load_balancing_scheme == "EXTERNAL" || var.load_balancing_scheme == "NONE"
#     error_message = "The load balancing scheme must be INTERNAL, EXTERNAL, or NONE."
#   }
# }

# variable "net_lb_subnet_ids" {
#   type        = list(string)
#   description = "The subnet IDs in the VPC to host the load balancer in."
#   nullable    = false
#   # Validate for list of 3
# }

# variable "net_vault_subnet_ids" {
#   type        = list(string)
#   description = "(required) The subnet IDs in the VPC to host the Vault servers in"
#   nullable    = false
#   # Validate for list of 3
# }

variable "net_vpc_id" {
  type        = string
  description = "(required) The VPC ID to host the cluster in"
  nullable    = false
}

variable "resource_tags" {
  type        = map(string)
  description = "A map containing tags to assign to all resources"
  default     = {}
}

# variable "vault_health_endpoints" {
#   type        = map(string)
#   description = "The status codes to return when querying Vault's sys/health endpoint"
#   default = {
#     standbyok              = "true"
#     perfstandbyok          = "true"
#     activecode             = "200"
#     standbycode            = "429"
#     drsecondarycode        = "472"
#     performancestandbycode = "473"
#     sealedcode             = "503"

#     # Allow unitialized clusters to be considered healthy. Default is 501.
#     uninitcode = "200"
#   }
# }

# variable "vault_port_api" {
#   type        = string
#   description = "The port the Vault API port will listen on"
#   default     = "8200"
# }

variable "vault_port_cluster" {
  type        = string
  description = "The port the Vault cluster port will listen on"
  default     = "8201"
}

variable "prefix" {
  type = string
}

variable "vault_count" {
  type = number

}
