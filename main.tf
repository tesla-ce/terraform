provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  default_tags {
    tags = {
      Environment = "Test"
      Project     = "tesla_ce"
   }
 }
}

resource "aws_cloudwatch_log_group" "tesla_ce" {
  name = "tesla_ce"
  tags = {
    Name = "TeSLA CE Log Group"
  }
}
