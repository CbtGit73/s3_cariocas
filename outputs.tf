#Creates the hosted website in the terminal. You still have to open the AWS console and investigate your newly created resources.

output "s3_url" {
  description = "S3 hosting URL (HTTP)"
  value       = aws_s3_bucket_website_configuration.hosting.website_endpoint
}