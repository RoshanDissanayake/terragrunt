locals {
  environment = "dev"
}

terraform {
  source = "../../../infrastructure-module/ec2"
}

inputs = {
  region              = "us-west-2"
  ami_id              = "ami-06a974f9b8a97ecf2" # update with a valid AMI
  instance_type       = "t2.micro"
  subnet_id           = "subnet-0cad945e9b19efc4b"
  security_group_ids  = ["sg-06acccff24547a685"] # update with a valid SG
  instance_name       = "dev-ec2"
  environment         = local.environment
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "amazonkendra-dataloader"
    key            = "dev/ec2/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    skip_credentials_validation = true
    skip_metadata_api_check    = true
  }
}