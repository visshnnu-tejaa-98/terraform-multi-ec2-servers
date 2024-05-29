variable "us-east-1" {
  default = "us-east-1"
}

variable "ap-south-1" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "first instance"
}

variable "amis" {
  type = map(any)
  default = {
    us-east-1  = "ami-04b70fa74e45c3917"
    ap-south-1 = "ami-0cc9838aa7ab1dce7"
  }
}
