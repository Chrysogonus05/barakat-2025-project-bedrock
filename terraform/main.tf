# main.tf

# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0" # Latest stable as of 2026

  name = "project-bedrock-vpc" # This sets the Name tag on VPC

  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"] # At least 2 AZs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Enable NAT for private subnets outbound internet (required for EKS nodes to pull images)
  enable_nat_gateway = true
  single_nat_gateway = false # One NAT per AZ for HA
  enable_vpn_gateway = false

  # Critical tags for EKS (ALB controller will use these later if bonus)
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1" # For public ALBs
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1" # For internal ALBs
  }

  # Global tags for ALL resources created by module
  tags = {
    Project = "barakat-2025-capstone"
  }

  vpc_tags = {
    Name    = "project-bedrock-vpc"
    Project = "barakat-2025-capstone"
  }
}