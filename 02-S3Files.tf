 #bucket objects
resource "aws_s3_bucket_object" "file" {
  for_each     = fileset(path.module, "content/**/*.{html,css,js,png,jpeg}")
  bucket       = aws_s3_bucket.bucket.id
  key          = replace(each.value, "/^content//", "")
  source       = each.value
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)
  etag         = filemd5(each.value)
  acl             = "public-read" 
}

resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.bucket.id
    
  index_document {
   
    suffix = "index.html"

    
  }
  }
