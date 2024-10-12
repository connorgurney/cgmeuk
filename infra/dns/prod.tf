# Root TXT records
# I do this here as Amazon Route 53 doesn’t support having more than one TXT
# record at the root of the zone.
resource "aws_route53_record" "prod_root_txt" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id
  
  name    = ""
  type    = "TXT"
  ttl     = "3600"
  records = [
    # Email SPF
    "v=spf1 include:spf.protection.outlook.com -all",

    # Microsoft domain verification
    "MS=ms82745659",

    # Google Site Verification
    "google-site-verification=enhNY1VAXCqQ5qPgLsAWfaLjoUjSeVB_sk3UifO5E00"
  ]
}


# WWW record
resource "aws_route53_record" "prod_www" {
  count = var.environment == "prod" ? 1 : 0
  
  zone_id = aws_route53_zone.this.zone_id

  name = "www"
  type = "A"
  
  alias {
    # This indicates that the alias is to Amazon CloudFront
    # See: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset-aliastarget.html
    zone_id = "Z2FDTNDATAQYW2"
    
    # This is currently set manually
    name = "d24oql8kyu7p0m.cloudfront.net"

    evaluate_target_health = false
  }
}

# Email routing
resource "aws_route53_record" "prod_mx" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id

  name    = ""
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 connorgurney-me-uk.mail.protection.outlook.com"
  ]
}

# Email DMARC
resource "aws_route53_record" "prod_dmarc" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id

  name    = "_dmarc"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; adkim=s; aspf=s; fo=1; rua=mailto:postmaster@connorgurney.me.uk; ruf=mailto:postmaster@connorgurney.me.uk"
  ]
}

# Email DKIM
resource "aws_route53_record" "prod_dkim_1" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id

  name    = "selector1._domainkey"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector1-connorgurney-me-uk._domainkey.connorgurney.onmicrosoft.com"
  ]
}

resource "aws_route53_record" "prod_dkim_2" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id

  name    = "selector2._domainkey"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector2-connorgurney-me-uk._domainkey.connorgurney.onmicrosoft.com"
  ]
}

# Email autodiscovery
resource "aws_route53_record" "prod_autodiscover" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id

  name    = "autodiscover"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "autodiscover.outlook.com"
  ]
}

# MDM registration
resource "aws_route53_record" "prod_mdm_registration" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id

  name    = "enterpriseregistration"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "enterpriseregistration.windows.net"
  ]
}

# MDM enrollment
resource "aws_route53_record" "prod_mdm_enrollment" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id

  name    = "enterpriseenrollment"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "enterpriseenrollment-s.manage.microsoft.com"
  ]
}

# Namespace registration for development environment
resource "aws_route53_record" "prod_dev" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id

  name    = "dev"
  type    = "NS"
  ttl     = "3600"
  records = [
    "ns-562.awsdns-06.net",
    "ns-413.awsdns-51.com",
    "ns-1408.awsdns-48.org",
    "ns-1830.awsdns-36.co.uk"
  ]
}

# Namespace registration for internal subdomain
resource "aws_route53_record" "prod_internal" {
  count = var.environment == "prod" ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id
  
  name    = "internal"
  type    = "NS"
  ttl     = "3600"
  records = [
    "ns-806.awsdns-36.net",
    "ns-364.awsdns-45.com",
    "ns-1588.awsdns-06.co.uk",
    "ns-1481.awsdns-57.org"
  ]
}
