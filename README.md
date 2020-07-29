# bigbluebutton-deploy

Terraform templates to provision a bigbluebutton server. Ansible playbook to run [bbb-install.sh](https://github.com/bigbluebutton/bbb-install)

## Requirements

- AWS Account
- Route53 Domain Name and Domain Zone
- Terraform 12.x+
- Ansible 2.9+

## Usage

Adjust configurations

- [`variables.tf`](variables.tf)
- [`ansible.cfg`](ansible.cfg)
- [`hosts`](hosts)

Initiate a new Terraform state

```sh
terraform init
```

Plan and apply your changes, provisionning the resources

```sh
terraform apply 
```

Run ansible playbook

```sh
ansible-playbook playbook.yaml
```

In case you need to destroy the resources

```sh
terraform destroy
```