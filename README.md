# Terraform_Demo_Workspace

this is a demo project to learn terraform workspace

## Key Steps

### Initialize Project

```sh
cd infra
terraform init
```

### Dev Workspace

- Create dev workspace

```sh
# create workspace
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
```

- Apply

```sh
terraform fmt && terraform validate
terraform plan
terraform apply -auto-approve

terraform destroy -auto-approve
```

![pic](./docs/image/workspace_dev.png)

---

### Prod Workspace

- Create prod workspace

```sh
# create workspace
terraform workspace new prod
# Created and switched to workspace "prod"!

# You're now on a new, empty workspace. Workspaces isolate their state,
# so if you run "terraform plan" Terraform will not see any existing state
# for this configuration.

terraform workspace list
#   default
#   dev
# * prod


terraform workspace show
# prod
```

- Apply

```sh
terraform fmt && terraform validate
terraform plan
terraform apply -auto-approve

terraform destroy -auto-approve
```

![pic](./docs/image/workspace_prod.png)

---

## Key Code

```terraform
resource "aws_instance" "app" {
  count = terraform.workspace == "prod" ? 3 : 1

  ami           = var.ami_id
  instance_type = terraform.workspace == "prod" ? "t2.large" : "t2.micro"
  subnet_id     = aws_subnet.private.id
}
```

- workspace in state

![pic](./docs/image/workspace_state.png)
