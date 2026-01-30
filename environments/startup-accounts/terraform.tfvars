region              = "eu-west-2"
source_profile      = "management"

audit_operator_role_arn = "arn:aws:iam::<AUDIT_ACCOUNT_ID>:role/AuditSecurityOperatorRole"
external_id            = "f17dd810-1dcd-4eff-8f05-a2edcddab6b6"

accounts = {
  dev    = "<DEV_ACCOUNT_ID>"
  uat    = "<UAT_ACCOUNT_ID>"
  prod2  = "<PROD2_ACCOUNT_ID>"
  gaming = "<GAMING_AI_ACCOUNT_ID>"
}

