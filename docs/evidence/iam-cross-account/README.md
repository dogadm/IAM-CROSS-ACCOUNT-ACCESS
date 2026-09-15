# Cross-Account IAM Validation Evidence

This directory contains validation evidence for the cross-account IAM trust model implemented in this project.

The validation confirms that the authorised Audit account role can assume a restricted security-audit role in the target Workload account, while unauthorised trust conditions and privileged IAM actions are denied.

## Validation Objectives

The tests verify that:

1. the authorised `AuditSecurityOperatorRole` can assume the workload account `SecurityAuditRole`;
2. the resulting STS session operates in the target workload account;
3. authorised read-only inspection actions are permitted;
4. privileged IAM write operations are denied;
5. AssumeRole requests using an invalid External ID are rejected.

## Trust Path

```text
Audit Account
339712711421
        |
        v
AuditSecurityOperatorRole
        |
        | sts:AssumeRole
        | + External ID
        v
Workload Account
905418272482
        |
        v
SecurityAuditRole
        |
        v
Temporary STS Session
```

## Evidence

### 1. Audit Account Source Identity

**File:** `01-audit-caller-identity.png`

Demonstrates that the source identity is the authorised `AuditSecurityOperatorRole` in the Audit account before the cross-account role assumption is performed.

Expected identity:

```text
Account: 339712711421
Role: AuditSecurityOperatorRole
```

---

### 2. Successful Cross-Account Role Assumption

**File:** `02-successful-assume-role.png`

Demonstrates that the authorised Audit account role can successfully call `sts:AssumeRole` against the workload account `SecurityAuditRole` when the required trust conditions are satisfied.

Expected target role:

```text
arn:aws:iam::905418272482:role/SecurityAuditRole
```

Expected result:

```text
AssumeRole -> ALLOWED
```

---

### 3. Workload Account Caller Identity

**File:** `03-workload-caller-identity.png`

Demonstrates that the temporary STS credentials returned by the AssumeRole operation are operating in the workload account as `SecurityAuditRole`.

Expected identity:

```text
Account: 905418272482
Role: SecurityAuditRole
```

This confirms that the cross-account trust path has successfully established a temporary security-audit session in the target account.

---

### 4. Read-Only Action Allowed

**File:** `04-readonly-action-allowed.png`

Demonstrates that the assumed `SecurityAuditRole` can perform authorised read-only inspection operations required for security auditing.

Expected result:

```text
Read-only security inspection -> ALLOWED
```

This validates that the role has sufficient permissions to perform its intended audit function.

---

### 5. Invalid External ID Rejected

**File:** `05-invalid-external-id-denied.png`

Demonstrates that an AssumeRole request using an incorrect External ID is rejected by the workload account trust policy.

Expected result:

```text
AssumeRole with invalid External ID -> DENIED
```

This validates enforcement of the configured trust-policy condition.

---

### 6. Privileged IAM Operation Denied

**File:** `06-privileged-action-denied.png`

Demonstrates that the assumed `SecurityAuditRole` cannot perform privileged IAM write operations.

Expected result:

```text
Privileged IAM modification -> DENIED
```

This validates that the workload security-audit role follows the principle of least privilege and cannot modify IAM resources.

## Validation Results

| Test                                | Expected Result | Security Objective             |
| ----------------------------------- | --------------- | ------------------------------ |
| Authorised cross-account AssumeRole | ALLOWED         | Validate approved trust path   |
| Workload STS identity               | ALLOWED         | Confirm target-account session |
| Read-only inspection                | ALLOWED         | Enable security auditing       |
| Invalid External ID                 | DENIED          | Enforce trust condition        |
| Privileged IAM modification         | DENIED          | Enforce least privilege        |

## Security Outcome

The validation demonstrates the intended steady-state security model:

```text
Authorised Audit Role
        |
        | Correct trust conditions
        v
SecurityAuditRole
        |
        +------ Read-only inspection ------> ALLOWED
        |
        +------ Privileged IAM changes ----> DENIED


Invalid trust condition
        |
        +------ sts:AssumeRole ------------> DENIED
```

The results demonstrate that the cross-account IAM implementation provides:

* controlled cross-account role assumption;
* temporary STS-based access;
* explicit trust-policy enforcement;
* External ID validation;
* read-only workload inspection;
* least-privilege access controls;
* denial of privileged IAM modification.

Together, these controls validate the intended cross-account security and least-privilege model.
