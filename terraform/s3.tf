resource "aws_s3_bucket" "myBucket" {
    bucket = var.bucket_name
    acl = "public-read"

    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": ["s3:GetObject"],
            "Resource": ["arn:aws:s3:::${var.bucket_name}/*"]
        }
    ]
}
POLICY

    website {
      index_document = "index.html"
    }
}

resource "aws_s3_bucket_object" "entryPage" {
  bucket = aws_s3_bucket.myBucket.id
  key =  "index.html"
  source = "../index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "styles" {
  bucket = aws_s3_bucket.myBucket.id
  key =  "styles.css"
  source = "../src/styles.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_object" "image" {
  bucket = aws_s3_bucket.myBucket.id
  key =  "some_Logo.png"
  source = "../src/some_Logo.png"
  content_type = "image/png"
}