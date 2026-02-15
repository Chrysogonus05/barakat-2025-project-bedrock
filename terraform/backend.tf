terraform {
  backend "s3" {
    bucket         = "bedrock-remote-state-altsoe0250342" # your bucket
    key            = "project-bedrock/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock" # must match exact table name
    encrypt        = true
  }
}