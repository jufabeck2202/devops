# Terraform 

## Configuration

### Custom AWS User 
In `~/.aws/creadentails`:
```
[terraform]
aws_access_key_id = A...Q
aws_secret_access_key = Q...i
```
and select credentials using `key_name`
```hcl
resource "aws_instance" "example"  {
        ami                     = "example"
        instance_type   = "t2.nano"
        key_name = "terraform"
}
```

### Dependencies Graüh
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
