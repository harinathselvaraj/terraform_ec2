# Terraform

https://medium.com/@dwdraju/dive-into-aws-with-terraform-e73652206192

Infrastructure as a code - similar to CloudFormation but for many cloud providers. ex) AWS, Google Cloud, Azure

Create EC2 Instance from AMI available on AWS Marketplace
configure the software on the instance using custom user data

Pre requisite - have credentials setup in AWS CLI

Step 1 : Create keys and get the access key and password
        AWS Keys
        AKIATEB2QI3C3YDZJ3XX
        LGWaFbTBx5qRAWJOGnvfTroNm0+V2Giutau/bzt/

Step 2: Download terraform from terraform.io

        brew install hashicorp/tap/terraform
        brew upgrade hashicorp/tap/terraform
        terraform -help
        terraform -v

Step 3: Keep the credentials file in the location - ~/.aws/credentials

    [default]
    aws_access_key_id = AKIATEB2QI3C3YDZJ3XX
    aws_secret_access_key = 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

    or just type "aws configure"

Step 4: Terraform file
Only modify the variable - "shared_cred_file"
ami-3ec9fd5b - Amazon Linux AMI

You can't connect via SSH since you didn't specify the keypair - key_name. Download the keypair from EC2 Instance. 


main.tf - IAAC (Infrastructure As A Code file)

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


terraform init
terraform plan
terraform apply
    Plan: 1 to add, 0 to change, 0 to destroy.
    when you edit the terraform file, and run this command again, This will force new resource i.e. destroy the previous ec2 instance and create new one with the key.

terraform destroy

## Connect to EC2 after its been created

PEM FIle - 
    ec2 -> Network & Security -> Key Pairs -> Create new pair
    Download - aws.pem file from AWS
    Change the permission
    chmod 400 aws.pem

Configure inbound rule to allow ssh into the instance - 
    EC2 -> Security Groups -> Inbound Rules -> Add a new role
    SSH - TCP - 22 - 0.0.0.0/0
    
ssh -i /Users/harinathselvaraj/Documents/notes/manual/terraform/aws.pem ubuntu@ec2-18-222-171-251.us-east-2.compute.amazonaws.com