# Simple Kubernetes Service using Terraform
## Prerequisites:
- DigitalOcean account
- DigitalOcean secure token
- Terraform
## Usage:
```sh
terraform init
```
This will initialize terrafrom and load the required plugins.
```sh
terraform plan
```
This will print out what resources are going to be created. Review them and then use,
```sh
terraform apply
```
By answering 'yes', a basic kubernetes cluster with an nginx deployment and a loadbalancer ingress controller will spin up.****