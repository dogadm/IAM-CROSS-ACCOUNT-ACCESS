module "security_audit_dev" {
  source                 = "../../modules/security_audit_role"
  providers              = { aws = aws.dev }
  audit_operator_role_arn = var.audit_operator_role_arn
  external_id            = var.external_id
  role_name              = "SecurityAuditRole"
}

module "security_audit_uat" {
  source                 = "../../modules/security_audit_role"
  providers              = { aws = aws.uat }
  audit_operator_role_arn = var.audit_operator_role_arn
  external_id            = var.external_id
  role_name              = "SecurityAuditRole"
}

module "security_audit_prod2" {
  source                 = "../../modules/security_audit_role"
  providers              = { aws = aws.prod2 }
  audit_operator_role_arn = var.audit_operator_role_arn
  external_id            = var.external_id
  role_name              = "SecurityAuditRole"
}

module "security_audit_gaming" {
  source                 = "../../modules/security_audit_role"
  providers              = { aws = aws.gaming }
  audit_operator_role_arn = var.audit_operator_role_arn
  external_id            = var.external_id
  role_name              = "SecurityAuditRole"
}
