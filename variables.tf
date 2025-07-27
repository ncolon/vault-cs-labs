#------------------------------------------------------------------------------
# Common
#------------------------------------------------------------------------------
variable "friendly_name_prefix" {
  type        = string
  description = "Friendly name prefix used for tagging and naming AWS resources."
}

variable "common_tags" {
  type        = map(string)
  description = "Map of common tags for all taggable AWS resources."
  default     = {}
}

variable "region" {
  type        = string
  description = "AWS region to create resource in."
}

#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
variable "create_vpc" {
  type        = bool
  description = "Boolean to create a VPC."
  default     = false
}
variable "create_nat_gateway" {
  type        = bool
  description = "Boolean to create a NAT Gateway."
  default     = false
}

variable "vpc_name" {
  type        = string
  description = "Name of VPC."
  default     = "vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC."
  default     = null
}

variable "lb_is_internal" {
  type        = bool
  description = "Boolean to create an internal (private) load balancer."
  default     = true
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDR ranges to create in VPC."
  default     = []
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDR ranges to create in VPC."
  default     = []
}

variable "create_bastion" {
  type        = bool
  description = "Boolean to create a bastion EC2 instance. Only valid when `create_vpc` is `true`."
  default     = false
}

variable "bastion_ec2_keypair_name" {
  type        = string
  description = "Existing SSH key pair to use for bastion EC2 instance."
  default     = null
}

variable "bastion_cidr_allow_ingress_ssh" {
  type        = list(string)
  description = "List of source CIDR ranges to allow inbound to bastion on port 22 (SSH)."
  default     = []
}

#------------------------------------------------------------------------------
# Vault Secrets Manager
#------------------------------------------------------------------------------
variable "vault_license_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault license."
  default     = "vault-license"
}

variable "vault_license_secret_value" {
  type        = string
  description = "Raw contents of the vault license file to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_encryption_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault encryption password."
  default     = "vault-encryption-password"
}

variable "vault_encryption_password_secret_value" {
  type        = string
  description = "Value of vault Encryption Password to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_database_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault database password."
  default     = "vault-database-password"
}

variable "vault_database_password_secret_value" {
  type        = string
  description = "Value of vault Database Password create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_redis_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault Redis password."
  default     = "vault-redis-password"
}

variable "vault_redis_password_secret_value" {
  type        = string
  description = "Value of vault Redis Password create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_cert_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault TLS certificate."
  default     = "vault-tls-cert-base64"
}

variable "vault_tls_cert_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of vault TLS certificate in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_privkey_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault TLS private key."
  default     = "vault-tls-privkey-base64"
}

variable "vault_tls_privkey_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of vault TLS private key in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_ca_bundle_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault TLS CA bundle."
  default     = "vault-tls-ca-bundle-base64"
}

variable "vault_tls_ca_bundle_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of vault TLS CA bundle in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

#------------------------------------------------------------------------------
# KMS
#------------------------------------------------------------------------------
variable "create_kms_cmk" {
  type        = bool
  description = "Boolean to create AWS KMS customer managed key (CMK)."
  default     = false
}

variable "kms_cmk_alias" {
  type        = string
  description = "Alias for KMS customer managed key (CMK)."
  default     = null
}

variable "kms_cmk_deletion_window" {
  type        = number
  description = "Duration in days to destroy the key after it is deleted. Must be between 7 and 30 days."
  default     = 7
}

variable "kms_cmk_enable_key_rotation" {
  type        = bool
  description = "Boolean to enable key rotation for the KMS customer managed key (CMK)."
  default     = false
}

variable "kms_allow_asg_to_cmk" {
  type        = bool
  description = "Boolen to create a KMS customer managed key (CMK) policy that grants the Service Linked Role 'AWSServiceRoleForAutoScaling' permissions to the CMK."
  default     = true
}

#------------------------------------------------------------------------------
# EC2 SSH Key Pairs
#------------------------------------------------------------------------------
variable "create_ec2_ssh_keypair" {
  type        = bool
  description = "Boolean to create EC2 SSH key pair. This is separate from the `bastion_keypair` input variable."
  default     = false
}

variable "ec2_ssh_keypair_name" {
  type        = string
  description = "Name of EC2 SSH key pair."
  default     = "ec2-keypair"
}

variable "ec2_ssh_public_key" {
  type        = string
  description = "Public key material for EC2 SSH Key Pair."
  default     = null
}

# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

#-----------------------------------------------------------------------------------
# Common
#-----------------------------------------------------------------------------------
variable "resource_tags" {
  type        = map(string)
  description = "A map containing tags to assign to all resources"
  default     = {}
}

variable "vault_fqdn" {
  type        = string
  description = "Fully qualified domain name to use for joining peer nodes and optionally DNS"
  nullable    = false
}

#------------------------------------------------------------------------------
# prereqs
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Vault configuration settings
#------------------------------------------------------------------------------
variable "vault_version" {
  type        = string
  description = "The version of Vault to use"
  default     = "1.17.3+ent"
}

variable "vault_disable_mlock" {
  type        = bool
  description = "Disable the server from executing the `mlock` syscall"
  default     = true
}

variable "vault_enable_ui" {
  type        = bool
  description = "Enable the Vault UI"
  default     = true
}

variable "vault_default_lease_ttl_duration" {
  type        = string
  description = "The default lease TTL expressed as a time duration in hours, minutes and/or seconds (e.g. `4h30m10s`)"
  default     = "1h"

  validation {
    condition     = can(regex("^([[:digit:]]+h)*([[:digit:]]+m)*([[:digit:]]+s)*$", var.vault_default_lease_ttl_duration))
    error_message = "Value must be a combination of hours (h), minutes (m) and/or seconds (s). e.g. `4h30m10s`"
  }
}

variable "vault_max_lease_ttl_duration" {
  type        = string
  description = "The max lease TTL expressed as a time duration in hours, minutes and/or seconds (e.g. `4h30m10s`)"
  default     = "768h"

  validation {
    condition     = can(regex("^([[:digit:]]+h)*([[:digit:]]+m)*([[:digit:]]+s)*$", var.vault_max_lease_ttl_duration))
    error_message = "Value must be a combination of hours (h), minutes (m) and/or seconds (s). e.g. `4h30m10s`"
  }
}

variable "vault_port_api" {
  type        = string
  description = "The port the Vault API will listen on"
  default     = "8200"
}

variable "vault_port_cluster" {
  type        = string
  description = "The port the Vault cluster port will listen on"
  default     = "8201"
}
variable "vault_telemetry_config" {
  type        = map(string)
  description = "Enable telemetry for Vault"
  default     = null

  validation {
    condition     = var.vault_telemetry_config == null || can(tomap(var.vault_telemetry_config))
    error_message = "Telemetry config must be provided as a map of key-value pairs."
  }

}
variable "vault_tls_disable_client_certs" {
  type        = bool
  description = "Disable client authentication for the Vault listener. Must be enabled when tls auth method is used."
  default     = true
}

variable "vault_tls_require_and_verify_client_cert" {
  type        = bool
  description = "Require a client to present a client certificate that validates against system CAs"
  default     = false
}

variable "vault_seal_type" {
  type        = string
  description = "The seal type to use for Vault"
  default     = "awskms"

  validation {
    condition     = var.vault_seal_type == "shamir" || var.vault_seal_type == "awskms"
    error_message = "The seal type must be shamir or awskms."
  }
}

variable "vault_raft_auto_join_tag" {
  type        = map(string)
  description = "A map containing a single tag which will be used by Vault to join other nodes to the cluster. If left blank, the module will use the first entry in `tags`"
  default     = null
}

variable "vault_raft_performance_multiplier" {
  description = "Raft performance multiplier value. Defaults to 0, which is the default Vault value."
  type        = number
  default     = 0

  validation {
    condition     = var.vault_raft_performance_multiplier >= 0 && var.vault_raft_performance_multiplier <= 10
    error_message = "Raft performance multiplier must be 0 (use Vault default) or an integer between 1 and 10."
  }

  validation {
    condition     = var.vault_raft_performance_multiplier == floor(var.vault_raft_performance_multiplier)
    error_message = "Raft performance multiplier must be an integer."
  }
}

#------------------------------------------------------------------------------
# System paths and settings
#------------------------------------------------------------------------------
variable "additional_package_names" {
  type        = set(string)
  description = "List of additional repository package names to install"
  default     = []
}

variable "vault_user_name" {
  type        = string
  description = "Name of system user to own Vault files and processes"
  default     = "vault"
}

variable "vault_group_name" {
  type        = string
  description = "Name of group to own Vault files and processes"
  default     = "vault"
}

variable "systemd_dir" {
  type        = string
  description = "Path to systemd directory for unit files"
  default     = "/lib/systemd/system"
}

variable "vault_dir_bin" {
  type        = string
  description = "The bin directory for the Vault binary"
  default     = "/usr/bin"
}

variable "vault_dir_config" {
  type        = string
  description = "The directory for Vault server configuration file(s)"
  default     = "/etc/vault.d"
}

variable "vault_dir_home" {
  type        = string
  description = "The home directory for the Vault system user"
  default     = "/opt/vault"
}

variable "vault_dir_logs" {
  type        = string
  description = "Path to hold Vault file audit device logs"
  default     = "/var/log/vault"
}

variable "vault_plugin_urls" {
  type        = list(string)
  default     = []
  description = "(optional list) List of Vault plugin fully qualified URLs (example [\"https://releases.hashicorp.com/terraform-provider-oraclepaas/1.5.3/terraform-provider-oraclepaas_1.5.3_linux_amd64.zip\"] for deployment to Vault plugins directory)"
}

variable "vault_snapshots_bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket for auto-snapshots"
  default     = null
}

#-----------------------------------------------------------------------------------
# Networking
#-----------------------------------------------------------------------------------
variable "net_ingress_ssh_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to allow SSH access to Vault instances."
  default     = []
}

variable "net_ingress_ssh_security_group_ids" {
  type        = list(string)
  description = "List of CIDR blocks to allow SSH access to Vault instances."
  default     = []
}

variable "net_ingress_vault_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to allow API access to Vault."
  default     = []
}

variable "net_ingress_vault_security_group_ids" {
  type        = list(string)
  description = "List of CIDR blocks to allow API access to Vault."
  default     = []
}

#-----------------------------------------------------------------------------------
# DNS
#-----------------------------------------------------------------------------------

# TBD


#-----------------------------------------------------------------------------------
# Compute
#-----------------------------------------------------------------------------------
variable "asg_node_count" {
  type        = number
  description = "The number of nodes to create in the pool."
  default     = 6
}

variable "asg_health_check_type" {
  type        = string
  description = "Defines how autoscaling health checking is done"
  default     = "EC2"

  validation {
    condition     = var.asg_health_check_type == "EC2" || var.asg_health_check_type == "ELB"
    error_message = "The health check type must be either EC2 or ELB."
  }
}

variable "asg_health_check_grace_period" {
  type        = string
  description = "The amount of time to expire before the autoscaling group terminates an unhealthy node is terminated"
  default     = 600
}

variable "vm_instance_type" {
  type        = string
  description = "The machine type to use for the Vault nodes"
  default     = "m7i.large"
}

variable "vm_image_id" {
  type        = string
  description = "The AMI of the image to use"
  default     = null
}

variable "vm_boot_disk_configuration" {
  description = "The disk (EBS) configuration to use for the Vault nodes"
  type = object(
    {
      volume_type           = string
      volume_size           = number
      delete_on_termination = bool
      encrypted             = bool
    }
  )
  default = {
    volume_type           = "gp3"
    volume_size           = 30
    delete_on_termination = true
    encrypted             = true
  }
}

variable "vm_vault_data_disk_configuration" {
  description = "The disk (EBS) configuration to use for the Vault nodes"
  type = object(
    {
      volume_type           = string
      volume_size           = number
      volume_iops           = number
      volume_throughput     = number
      delete_on_termination = bool
      encrypted             = bool
    }
  )
  default = {
    volume_type           = "gp3"
    volume_size           = 100
    volume_iops           = 3000
    volume_throughput     = 125
    delete_on_termination = true
    encrypted             = true
  }
}

variable "vm_vault_audit_disk_configuration" {
  description = "The disk (EBS) configuration to use for the Vault nodes"
  type = object(
    {
      volume_type           = string
      volume_size           = number
      delete_on_termination = bool
      encrypted             = bool
    }
  )
  default = {
    volume_type           = "gp3"
    volume_size           = 50
    delete_on_termination = true
    encrypted             = true
  }
}

variable "vm_key_pair_name" {
  type        = string
  description = "The machine SSH key pair name to use for the cluster nodes"
  default     = null
}

#-----------------------------------------------------------------------------------
# IAM variables
#-----------------------------------------------------------------------------------
variable "iam_role_path" {
  type        = string
  description = "Path for IAM entities"
  default     = "/"
}

variable "iam_role_permissions_boundary_arn" {
  type        = string
  description = "The ARN of the policy that is used to set the permissions boundary for the role"
  default     = null
}

#-----------------------------------------------------------------------------------
# Load Balancer variables
#-----------------------------------------------------------------------------------
variable "load_balancing_scheme" {
  type        = string
  description = "Type of load balancer to use (INTERNAL, EXTERNAL, or NONE)"
  default     = "INTERNAL"

  validation {
    condition     = var.load_balancing_scheme == "INTERNAL" || var.load_balancing_scheme == "EXTERNAL" || var.load_balancing_scheme == "NONE"
    error_message = "The load balancing scheme must be INTERNAL, EXTERNAL, or NONE."
  }
}

variable "vault_health_endpoints" {
  type        = map(string)
  description = "The status codes to return when querying Vault's sys/health endpoint"
  default = {
    standbyok              = "true"
    perfstandbyok          = "true"
    activecode             = "200"
    standbycode            = "429"
    drsecondarycode        = "472"
    performancestandbycode = "473"
    sealedcode             = "503"

    # Allow unitialized clusters to be considered healthy. Default is 501.
    uninitcode = "200"
  }
}

variable "health_check_interval" {
  type        = number
  description = "Approximate amount of time, in seconds, between health checks of an individual target. The range is 5-300."
  default     = 5

  validation {
    condition     = var.health_check_interval >= 5 && var.health_check_interval <= 300
    error_message = "The health check interval must be between 5 and 300."
  }
}

variable "health_check_timeout" {
  type        = number
  description = "Amount of time, in seconds, during which no response from a target means a failed health check. The range is 2–120 seconds."
  default     = 3

  validation {
    condition     = var.health_check_timeout >= 2 && var.health_check_timeout <= 120
    error_message = "The health check timeout must be between 2 and 120."
  }
}

variable "health_check_deregistration_delay" {
  type        = number
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds."
  default     = 15

  validation {
    condition     = var.health_check_deregistration_delay >= 0 && var.health_check_deregistration_delay <= 3600
    error_message = "The health check deregistration delay must be between 0 and 3600."
  }
}

variable "stickiness_enabled" {
  type        = bool
  description = "Enable sticky sessions by client IP address for the load balancer."
  default     = true
}
