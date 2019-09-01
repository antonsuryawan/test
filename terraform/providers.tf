provider "aws" {
  access_key = "${var.tf_aws_access_key}"
  secret_key = "${var.tf_aws_secret_key}"
  region     = "${var.tf_aws_region}"
}

