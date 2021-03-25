{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1616472269390",
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::${web_s3_bucket}/*"
      }
    ]
  }