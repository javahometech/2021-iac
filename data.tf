data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

# 
data "template_file" "init" {
  template = file("./files/web_s3_policy.tpl")
  vars = {
    web_s3_bucket = var.web_s3_bucket
  }
}

