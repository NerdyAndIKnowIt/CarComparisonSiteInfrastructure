//--------- Go to declare_variables.tfvars file to change the default variables ----------
//---------------------- Do not change any settings in this file--------------------------


//the domain name you would like to use
variable "domain_name" {
  default = "default"
  type    = string
}

//the default file for the website in the s3 bucket
variable "index" {
  default = "index.html"
  type    = string
}

//the AWS region must be us-east-1 for route 53 and cloudfront to work properly
variable "region" {
  default = "us-east-1"
  type    = string
}


