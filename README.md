# bigbluebutton-infra

**Note: This repository is in active development. Contributions are welcomed!**

Automation for BigBlueButton stack. Use Terraform and Ansible to provision bigbluebutton and scalelite with few commands.

## Requirements

- AWS Account
- Route53 Domain Name and Domain Zone
- Terraform 12.x+
- Ansible 2.9+

## Pre-Install

Adjust configurations

- [`vars/variables.tfvars`](vars/variables.tfvars)
- [`vars/ansible.cfg`](vars/ansible.cfg)
- [`vars/inventory`](vars/inventory)
- [`vars/variables.yaml`](vars/variables.yaml)

Note, Ansible inventory has to be adjusted after ec2 provisioning

## Infrastructure

Infrastructure creation is done in multiple steps:

1. Bootstrapping - creating shared resources, like security groups and SSH keys.
2. Provisioning - creating actual bigbluebutton and scalelite servers

### Bootstrapping

Initiate a new Terraform project in [`bootstrap`](bootstrap) directory:

```sh
terraform init
```

Plan and apply your changes, provisionning the resources:

```sh
terraform apply -var-file=../vars/variables.tfvars
```

### Provisionin

Initiate a new Terraform project in [`template`](template) directory:

```sh
terraform init
```

Plan and apply your changes, provisionning the resources:

```sh
terraform apply -var-file=../vars/variables.tfvars
```

## Configuration

Install required Ansible roles:

```sh
ansible-galaxy install nickjj.docker
```

Run Ansible playbook for bigbluebutton:

```sh
ansible-playbook playbooks/bigbluebutton.yaml
```

Run Ansible playbook for scalelite:

```sh
ansible-playbook playbooks/scalelite.yaml
```

## Post-Install

Post installation configuration is still pretty much manual. You will need to refer to [scalelite official docs](https://github.com/blindsidenetworks/scalelite#administration) to learn more how to administer your cluster.

In case you need to destroy the resources, the process is similar for both [`bootstrap`](bootstrap) and [`template`](template):

```sh
terraform destroy --auto-approve -var-file=../vars/variables.tfvars
```