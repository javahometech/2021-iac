resource "aws_iam_role" "web_s3_role" {
  name = "web_s3_role"

  assume_role_policy = file("./files/web_s3_role.json")
}

# Create policy and atach to IAM role

resource "aws_iam_role_policy" "web_s3_policy" {
  name = "web_s3_policy"
  role = aws_iam_role.web_s3_role.id

  policy = data.template_file.init.rendered
}

# Create IAM Instance profile, later attach to EC2

resource "aws_iam_instance_profile" "web_s3_profile" {
  name = "web_s3_profile"
  role = aws_iam_role.web_s3_role.name
}
