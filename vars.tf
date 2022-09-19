# Defining Region
variable "aws_region" {
  default = "ap-south-1"
}

# Defining CIDR Block for VPC
variable "vpc_cidr" {
  default = "40.0.0.0/16"
}

# Defining CIDR Block for Subnet
variable "subnetpub1_cidr" {
  default = "40.0.1.0/24"
}

# Defining CIDR Block for 2d Subnet
variable "subnetpub2_cidr" {
  default = "40.0.2.0/24"
}


# Defining Public Key
variable "public_key" {
  default = "bhs-nginx-key.pub"
}

# Defining Private Key
variable "private_key" {
  default = "bhs-nginx-key.pem"
}

# Definign Key Name for connection
variable "key_name" {
  default = "bhs-nginx-key.pem"
  description = "Desired name of AWS key pair"
}



# Defining AMI which is having our index.html file to host bhsworld.com
variable "ami" {
 # default = "ami-01c1009f059c6e694"
 # default = "ami-07050b42151ef470c"
  default = "ami-0745276ff99a9e05d"
}

# Defining Instace Type
variable "instancetype" {
  default = "t3.medium"
}

# Defining Master count ## As we are using EIP its restricting, wordkaround do exist but need to explore more.
#variable "master_count" {
#  default = 1
#}
