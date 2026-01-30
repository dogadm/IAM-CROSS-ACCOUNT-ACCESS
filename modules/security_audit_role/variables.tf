variable "role_name" {
  type    = string
  default = "SecurityAuditRole"
}

variable "audit_operator_role_arn" {
  type        = string
  description = "ARN of the Audit account operator role that can assume this role"
}

variable "external_id" {
  type        = string
  description = "ExternalId required to assume the role"
}

variable "max_session_duration" {
  type    = number
  default = 3600
}

variable "attach_viewonly" {
  type    = bool
  default = true
}

variable "attach_securityaudit" {
  type    = bool
  default = true
}
