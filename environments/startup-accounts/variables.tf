variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "source_profile" {
  type        = string
  description = "AWS CLI profile with credentials in the Management account (or wherever you authenticate first)"
  default     = "management"
}

variable "audit_operator_role_arn" {
  type        = string
  description = "ARN of AuditSecurityOperatorRole in the Audit account"
}

variable "external_id" {
  type        = string
  description = "ExternalId required by workload roles"
}

variable "accounts" {
  type = object({
    dev    = string
    uat    = string
    prod2  = string
    gaming = string
  })
}

