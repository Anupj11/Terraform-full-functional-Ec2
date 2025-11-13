variable "ami" {
  default = "ami-021a584b49225376d"

}

variable "instancetype" {
  default = "t2.micro"

}

variable "key_path" {
  type    = string
  default = "/home/anu/.ssh/id_rsa.pub"

}