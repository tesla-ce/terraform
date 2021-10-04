resource "aws_ecs_cluster" "tesla_ce" {
  name = "tesla_ce_cluster"

  configuration {
    execute_command_configuration {
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.tesla_ce.name
      }
    }
  }

  tags = {
    Name = "TeSLA CE ECS Cluster"
  }
}

resource "aws_ecr_repository" "tesla" {
  name                 = "tesla_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "TeSLA CE ECR"
  }
}

data "aws_ecr_authorization_token" "token" {
  depends_on = [aws_ecr_repository.tesla]
}

module "ecr_mirror" {
  source  = "TechToSpeech/ecr-mirror/aws"
  docker_source = "teslace/core:latest"
  aws_profile = "default"
  aws_account_id = data.aws_ecr_authorization_token.token.user_name
  aws_region = var.aws_region
  ecr_repo_name = aws_ecr_repository.tesla.repository_url
  ecr_repo_tag = "latest"
  depends_on = [data.aws_ecr_authorization_token.token]
}
