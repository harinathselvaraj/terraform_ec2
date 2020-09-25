variable "region" {
 default = "us-east-2"
}
variable "shared_cred_file" {
 default = "/Users/harinathselvaraj/.aws/configure"
}
provider "aws" {
 region = "${var.region}"
 shared_credentials_file = "${var.shared_cred_file}"
 profile = "default"
}
resource "aws_instance" "web" {
 ami = "ami-3ec9fd5b"
 instance_type = "t2.micro"
 key_name = "aws"
 tags = { Name = "myec2" }
}
