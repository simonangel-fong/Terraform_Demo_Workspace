# Terraform Demo Workspace — Implementation Plan

## Goal

Demonstrate Terraform workspaces by provisioning environment-specific AWS infrastructure
(VPC + EC2) in `ca-central-1`, using a local backend.

---

## File Structure

```
Terraform_Demo_Workspace/
├── docs/
│   └── plan.md
├── infra/
│   ├── main.tf           # VPC and EC2 resources
│   ├── variables.tf      # Input variables
│   ├── outputs.tf        # Output values
│   ├── locals.tf         # Workspace-driven local values (counts, names)
│   └── terraform.tf      # Required providers + local backend
├── .gitignore            # Exclude sensitive/local state files
└── README.md
```

---

## Resources

### VPC

| Attribute | Value              |
| --------- | ------------------ |
| Name tag  | `demo-<workspace>` |

### EC2

| Attribute | Value               |
| --------- | ------------------- |
| Name tag  | `ec2-<workspace>`   |
| Type      | `t3.micro`          |
| Count     | `dev: 1`, `prod: 3` |

Workspace-specific values are managed via a `locals` map so they can diverge later without structural changes.

---

## Backend

- **Type:** Local
- State files land in `infra/terraform.tfstate.d/<workspace>/` (Terraform default)
- State files and `.terraform/` are excluded from git via `.gitignore`

---

## `.gitignore` Entries

```
# Terraform local state and sensitive data
**/.terraform/
*.tfstate
*.tfstate.backup
*.tfstate.d/
.terraform.lock.hcl
*.tfvars
*.tfvars.json
```

---

## Provider

| Setting  | Value           |
| -------- | --------------- |
| Provider | `hashicorp/aws` |
| Region   | `ca-central-1`  |

---

## Workspace Workflow

```bash
cd infra/

# One-time setup
terraform init
terraform workspace new dev
terraform workspace new prod

# Deploy dev
terraform workspace select dev
terraform plan
terraform apply

# Deploy prod
terraform workspace select prod
terraform plan
terraform apply
```

---

## Implementation Steps

1. Create `.gitignore` at repo root with Terraform exclusions
2. Create `infra/terraform.tf` — provider and local backend
3. Create `infra/locals.tf` — workspace-keyed counts and name suffixes
4. Create `infra/variables.tf` — any input variables
5. Create `infra/main.tf` — VPC and EC2 resources using locals
6. Create `infra/outputs.tf` — VPC ID, EC2 IDs, current workspace
