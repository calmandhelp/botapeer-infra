output "bucket_alb_log" {
  value = aws_s3_bucket.bucket_alb_log
}
output "bucket_image_s3" {
  value = aws_s3_bucket.bucket_service_image
}
output "bucket_cloudfront" {
  value = aws_s3_bucket.bucket_cloudfront
}