# Terraform_Demo_Workspace


this is a demo project to learn terraform workspace

- environement: 
    - dev
    - prod

- resource:
  - vpc
    - name: demo-<workspace-name>
  - ec2
    - count:
      - dev: 1
      - prod: 1
    - type: t3.micro
    - name: ec2-<workspace-name>


```sh
cd infra
terraform init

terraform workspace new dev
# Created and switched to workspace "dev"!

# You're now on a new, empty workspace. Workspaces isolate their state,
# so if you run "terraform plan" Terraform will not see any existing state
# for this configuration.

terraform workspace show
# dev

terraform workspace list
#   default
# * dev

terraform fmt && terraform validate
terraform plan
terraform apply
```