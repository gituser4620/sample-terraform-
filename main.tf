# Declare input variables for AWS credentials
variable "AWS_ACCESS_KEY_ID" {
  type = string
  description = "AWS Access Key ID"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  description = "AWS Secret Access Key"
}

provider "aws" {
  region     = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "ayesha-demo-bucket-jenkins"
  # Remove deprecated acl argument here
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.bucket
  acl    = "private"
}

# Provider for a different region with credentials
provider "aws" {
  region     = "us-west-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  alias      = "west"
}

# You can now use the aliased provider in other resources
resource "aws_s3_bucket" "my_bucket_west" {
  provider = aws.west
  bucket   = "ayesha-demo-bucket-jenkins-west"
}

resource "aws_s3_bucket_acl" "my_bucket_acl_west" {
  provider = aws.west
  bucket   = aws_s3_bucket.my_bucket_west.bucket
  acl      = "private"
}
