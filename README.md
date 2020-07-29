# bigbluebutton-terraform

Terraform templates to provision a bigbluebutton server

**Note: currently you are still required to install the bigbluebutton stack manually.** The best way to do so is [bbb-install.sh](https://github.com/bigbluebutton/bbb-install)

## Requirements

- AWS Account
- Route53 Domain Name and Domain Zone
- Terraform 12.x

## Usage

Configure [`variables.tf`](variables.tf) file

Initiate a new Terraform state

```sh
terraform init
```

Plan and apply your changes, provisionning the resources

```sh
terraform apply 
```

In case you need to destroy the resources

```sh
terraform destroy
```