module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"
  name                 = "tesla-ce-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = var.availability_zone_names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "TeSLA CE VPC"
  }
}

resource "aws_security_group" "rds" {
  name   = "tesla_ce_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}

resource "aws_db_subnet_group" "tesla_ce_services" {
  name       = "tesla_ce_services_sg"
  subnet_ids = module.vpc.public_subnets
  tags = {
    Name = "Services Subnet Group"
  }
}
