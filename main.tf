provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "ayesha-demo-bucket-jenkins"
  acl    = "private"
}

# Use alias for the second provider
provider "aws" {
  region     = "us-west-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  alias      = "west"
}

# You can now use the aliased provider in other resources
resource "aws_s3_bucket" "my_bucket_west" {
  provider = aws.west  # Use the alias for the second provider
  bucket   = "ayesha-demo-bucket-jenkins-west"
  acl      = "private"
}
