# bigbluebutton-infra

**Note: This repository is in active development. Contributions are welcomed!**

Automation for BigBlueButton stack. Use Terraform and Ansible to provision bigbluebutton and scalelite with few commands.

## Requirements

- AWS Account
- Route53 Domain Name and Domain Zone
- Terraform 12.x+
- Ansible 2.9+

## Configuration

Adjust configurations

- [`variables.tf`](variables.tf)
- [`ansible.cfg`](ansible.cfg)
- [`inventory`](inventory)

For terraform, you can create a file named `vars.auto.tfvars`, and configure you variables like so

```hcl
aws_profile                  = "custom-profile"
bigbluebutton_domain_name    = "example.com"
bigbluebutton_subdomain_name = "server-1"
scalelite_domain_name        = "example.com"
scalelite_subdomain_name     = "lb"
```

## Usage

Initiate a new Terraform project

```sh
terraform init
```

Plan and apply your changes, provisionning the resources

```sh
terraform apply 
```

Run ansible playbook for bigbluebutton

```sh
ansible-playbook playbooks/bigbluebutton.yaml
```

Run ansible playbooks for scalelite

```sh
ansible-playbook playbooks/docker.yaml
ansible-playbook playbooks/scalelite.yaml
```

In case you need to destroy the resources

```sh
terraform destroy
```