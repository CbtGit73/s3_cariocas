#1 #Create S3 Bucket 
#  Create Bucket Name
resource "aws_s3_bucket" "bucket" {
  bucket = "cloudninjas-bucket-o-cariocas1"

}

resource "aws_s3_bucket_public_access_block" "s3_public_block" {
bucket = aws_s3_bucket.bucket.id

block_public_acls = false
block_public_policy = false
#ignore public acls
}


## 2 Configure Bucket Ownership to "BucketOwnerPreferred"
resource "aws_s3_bucket_ownership_controls" "s3controls" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
## 3 Bucket Versioning is disabled
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}


resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
          
        }
      ]
    }
  )
}