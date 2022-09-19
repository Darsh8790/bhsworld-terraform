####Step1:-  Only run seed module and provider block by commenting other code
####      Wait for S3 and dynamodb to be created 
####Step2:-  Only run 1st terraform state file block to create and store state file in S3 and comment out all other code.
####      Wait for State file to be pushed in S3.
####Step3:-  keep comment on seed_module and run the full code to create resource.

/*
# Require TF version to be same as or greater than 0.12.13
terraform {
required_version = ">=0.12"
backend "s3" {
bucket         = "bhsworld-terraform-s3-final"
key            = "terraform.tfstate"
region         = "ap-south-1"
dynamodb_table = "aws-locks-final"
encrypt        = true
}
}
*/


# #Call the seed_module to build our ADO seed info
module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = "bhsworld-terraform-s3-final"
  dynamo_db_table_name        = "aws-locks-final"
  iam_user_name               = "GitHubActionsIamUser"
  ado_iam_role_name           = "GitHubActionsIamRole"
  aws_iam_policy_permits_name = "GitHubActionsIamPolicyPermits"
  aws_iam_policy_assume_name  = "GitHubActionsIamPolicyAssume"
}




# Configure and downloading plugins for aws
provider "aws" {
  region     = "${var.aws_region}"
}

  
/*
# Creating VPC
resource "aws_vpc" "bhsvpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "BHS-WORLD-VPC"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "bhsgateway" {
  vpc_id = "${aws_vpc.bhsvpc.id}"
  tags = {
    Name = "BHS-WORLD-IGW"
  }
}


# Grant the internet access to VPC by updating its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.bhsvpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.bhsgateway.id}"
}

# Creating 1st subnet
resource "aws_subnet" "bhssubnetpub1" {
  vpc_id                  = "${aws_vpc.bhsvpc.id}"
  cidr_block             = "${var.subnetpub1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"

  tags = {
    Name = "BHS-WORLD-Subnet-Pub-1"
  }
}

# Creating 2nd subnet
resource "aws_subnet" "bhssubnetpub2" {
  vpc_id                  = "${aws_vpc.bhsvpc.id}"
  cidr_block             = "${var.subnetpub2_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"

  tags = {
    Name = "BHS-WORLD-Subnet-Pub-2"
  }
}

# Creating Security Group
resource "aws_security_group" "bhssg" {
  name        = "BHS-WORLD-Security-Group"
  description = "SG with exposing 80,443,22"
  vpc_id      = "${aws_vpc.bhsvpc.id}"

  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Using existing key pair
data "aws_key_pair" "bhs-nginx-key" {
  key_name   = "bhs-nginx-key"
  include_public_key = true
}

#Search EIP by allocation ID
data "aws_eip" "by_allocation_id" {
  id = "eipalloc-0e9613c45ac39a50a"
}

#Attach EIP to instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.bhsinstance.id}"
  allocation_id = "${data.aws_eip.by_allocation_id.id}"
}

# Creating EC2 Instance
resource "aws_instance" "bhsinstance" {

  # AMI based on region
  ami = "${var.ami}"

  # Launching instance into subnet
  subnet_id = "${aws_subnet.bhssubnetpub1.id}"

  # Instance type
  instance_type = "${var.instancetype}"

  # Count of instance
  #count= "${var.master_count}"

  # SSH key that we have generated above for connection
  key_name = "${data.aws_key_pair.bhs-nginx-key.key_name}"

  # Attaching security group to our instance
  vpc_security_group_ids = ["${aws_security_group.bhssg.id}"]

  # Attaching Tag to Instance
  tags = {
  #  Name = "BHS-WORLD-${count.index + 1}"
    Name = "BHS-Nginx-terraform-githubaction-Demo"
  }



  # SSH into instance
  connection {

    # Host name
    host = self.public_ip
    # The default username for our AMI
    user = "ubuntu"
    # Private key for connection
    private_key = "${file(var.private_key)}"
    # Type of connection
    type = "ssh"
  }

  # Installing nginx-docker for  http://bhsworld.com/  on newly created instance 
  provisioner "remote-exec" {
    inline = [
    #  "A=`(sudo docker ps -a |awk '{print $1}'|grep -Ev CONTAINE)`",
    #  "sudo docker rm $A",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt install docker.io -y",
      "sudo snap install docker",
      "sudo docker --version",
      "sudo docker pull nginx",
    #  "sudo docker run --name docker-nginx -p 80:80 -d nginx"
      "sudo docker run --name docker-nginxibhs -p 80:80 -d -v ~/docker-nginx/bhs:/usr/share/nginx/html nginx"
  ]
 }
}

*/
