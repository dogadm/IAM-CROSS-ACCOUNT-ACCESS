# Security Notes

This document records security assumptions, limitations, and operational
considerations for the IAM cross-account access architecture.

## Trust Model

The steady-state access model is:

```text
Human identity
    ↓
Audit account
    ↓
AuditSecurityOperatorRole
    ↓
AWS STS AssumeRole
    ↓
Workload account role
```
Workload accounts do not require dedicated IAM users for security operations.

## Bootstrap Access

`OrganizationAccountAccessRole` is used only for initial bootstrap or
break-glass access.

It is not intended to be the normal operational access path.

Steady-state access uses dedicated, explicitly trusted roles.

## ExternalId

`ExternalId` is not treated as a password or secret.

AWS primarily uses External IDs to address confused-deputy risks in
third-party or multi-tenant cross-account scenarios.

Within this organisation-controlled architecture, the primary trust controls
are:

- explicit trusted-role principals;
- least-privilege `sts:AssumeRole` permissions;
- short-lived STS credentials;
- restricted session duration;
- CloudTrail logging.

Where configured, `ExternalId` is an additional AssumeRole condition.

## MFA Boundary

MFA is enforced at the human authentication boundary.

MFA context is not assumed to propagate reliably through chained role
sessions.

Subsequent role-to-role assumptions therefore rely on explicit role trust and
short-lived STS credentials.

## Workforce Identity

A production enterprise implementation would typically use AWS IAM Identity
Center or another federated workforce identity provider for human
authentication.

This repository focuses on the IAM cross-account role architecture behind
that authentication layer.

## Least Privilege

Target-account roles should grant only the permissions required for their
specific operational function.

Examples include:

- read-only security review;
- incident-response actions;
- controlled deployment operations.

Broad administrative access is reserved for bootstrap or approved break-glass
scenarios.

## Session Security

Cross-account access uses temporary STS credentials.

Short session durations reduce the exposure window if a session is
compromised.

## Auditability

Cross-account role assumptions should be monitored through AWS CloudTrail.

Relevant events include:

- `AssumeRole`;
- failed role assumptions;
- unexpected source principals;
- unusual role-session activity.

## Known Limitations

The current portfolio implementation does not yet provide:

_ full IAM Identity Center automation;
- organisation-wide StackSet deployment;
- production SIEM integration;
- automated access reviews;
- full break-glass workflow automation;
- centralised IAM anomaly detection.

These are considered future enterprise extensions rather than requirements
for demonstrating the core cross-account trust model.

---
