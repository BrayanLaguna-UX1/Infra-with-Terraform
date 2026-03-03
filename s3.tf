resource "aws_s3_bucket" "mys3" {
    bucket = "Bucketmine852tfbr"
    tags = {
      Name= "Bucketmine852tfbr"
    }
    
}

resource "aws_s3_bucket_public_access_block" "blockbuck" {
    bucket = aws_s3_bucket.mys3.id
    
    restrict_public_buckets = true
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
  
}