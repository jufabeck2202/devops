

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

# Ubuntu 20.0
variable "aws_amis" {
  default = {
    us-east-1 = "ami-016be23323eaf9e35"
  }
}

variable "public_key_path" {
  default = "/Users/julianbeck/.ssh/id_rsa.pub"
}