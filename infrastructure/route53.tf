data "aws_route53_zone" "selected_zone" {
  name = var.domain_name
}


resource "aws_route53_record" "domain_A" {
  zone_id = data.aws_route53_zone.selected_zone.zone_id
  name = var.domain_name
  type = "A"

  alias {
    name = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [aws_cloudfront_distribution.cloudfront]
}