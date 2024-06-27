provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-west-2"
  endpoints {
    ec2 = "http://localhost:4566"
    sns = "http://localhost:4566"
    lambda = "http://localhost:4566"
  }
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
 # s3_force_path_style         = true
}
