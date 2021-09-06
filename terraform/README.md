# Terraform 
> Infrastructure as Code


## Configuration

### Custom AWS User 
In `~/.aws/creadentails`:
```
[terraform]
aws_access_key_id = A...Q
aws_secret_access_key = Q...i
```
and select credentials using `profile`
```
provider "aws" {
  region                  = "your region"
  profile                 = "profile_name"
}
```

### Dependencies Graph
```
terraform graph | dot -Tpng > graph.png
```
### Assigning Variables
Directly via cmd
```sh
terraform plan \
  -var 'access_key=foo' \
  -var 'secret_key=bar'
```
or via `terraform.tfvars`
```sh
access_key="foo"
```
Specify var-file:
```sh
terraform plan \
  -var-file="secret.tfvars" \
  -var-file="production.tfvars"
 ```
