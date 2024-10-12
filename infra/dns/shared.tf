# DNS zone itself
resource "aws_route53_zone" "this" {
  name = var.domains[0]
}

# Root record
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.this.zone_id
  name    = ""
  type    = "A"
  
  alias {
    # This indicates that the alias is to Amazon CloudFront
    # See: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset-aliastarget.html
    zone_id = "Z2FDTNDATAQYW2"
    
    # This is currently set manually
    name = "d24oql8kyu7p0m.cloudfront.net"

    evaluate_target_health = false
  }
}
