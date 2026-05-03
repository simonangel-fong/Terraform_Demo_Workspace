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
│   ├── 01_variables.tf   # Input variables
│   ├── 02_terraform.tf   # Required providers + local backend
│   ├── 03_main.tf        # VPC, subnet, and EC2 resources
│   └── 99_outputs.tf     # Output values
├── .gitignore            # Exclude sensitive/local state files
└── README.md
```

---

## Resources

### VPC

| Attribute    | Value                                    |
| ------------ | ---------------------------------------- |
| CIDR block   | `var.vpc_cidr_block` (default `10.0.0.0/16`) |
| Name tag     | `<project_name>_<workspace>_vpc`         |
| DNS support  | enabled                                  |

### Private Subnet

| Attribute         | Value                                       |
| ----------------- | ------------------------------------------- |
| CIDR block        | `var.subnet_cidr_block` (default `10.0.1.0/24`) |
| Availability zone | `var.availability_zone` (default `ca-central-1a`) |
| Name tag          | `<project_name>_<workspace>_private_subnet` |

### EC2

| Attribute | Value                                          |
| --------- | ---------------------------------------------- |
| Name tag  | `<project_name>_<workspace>_ec2_<index>`       |
| AMI       | `var.ami_id` (Amazon Linux 2023, `ca-central-1`) |
| Type      | `t2.micro` (dev), `t2.large` (prod)            |
| Count     | `1` (dev), `3` (prod)                          |
| Subnet    | private subnet (above)                         |

Workspace-specific values (`count`, `instance_type`) are controlled inline via `terraform.workspace` conditionals in `03_main.tf`.

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
| Version  | `~> 5.0`        |
| Region   | `ca-central-1`  |

---

## Variables

| Variable           | Type   | Default                  | Description                              |
| ------------------ | ------ | ------------------------ | ---------------------------------------- |
| `project_name`     | string | `demo-tf-workspace`      | Base name used in all resource name tags |
| `ami_id`           | string | `ami-0dd6ad74006372963`  | Amazon Linux 2023 AMI in `ca-central-1`  |
| `availability_zone`| string | `ca-central-1a`          | AZ for the private subnet                |
| `vpc_cidr_block`   | string | `10.0.0.0/16`            | CIDR block for the VPC                   |
| `subnet_cidr_block`| string | `10.0.1.0/24`            | CIDR block for the private subnet        |

---

## Outputs

| Output              | Description                  |
| ------------------- | ---------------------------- |
| `workspace`         | Current Terraform workspace  |
| `vpc_id`            | ID of the VPC                |
| `private_subnet_id` | ID of the private subnet     |
| `ec2_ids`           | List of EC2 instance IDs     |

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
2. Create `infra/02_terraform.tf` — provider (`hashicorp/aws ~> 5.0`) and local backend
3. Create `infra/01_variables.tf` — input variables with defaults
4. Create `infra/03_main.tf` — VPC, private subnet, and EC2 resources; workspace conditionals inline
5. Create `infra/99_outputs.tf` — workspace, VPC ID, subnet ID, EC2 IDs
