resource "aws_acm_certificate" "ssl_cert" {
  domain_name = var.domain_name
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation" {
    zone_id = data.aws_route53_zone.selected_zone.zone_id
    name = each.value.name
    type = each.value.type
    ttl = 60
    records = [each.value.value]

    for_each = { for validation_domain in aws_acm_certificate.ssl_cert.domain_validation_options : validation_domain.domain_name => {
            name = validation_domain.resource_record_name
            type = validation_domain.resource_record_type
            value = validation_domain.resource_record_value
        }
    }

}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.ssl_cert.arn
  validation_record_fqdns = [for record in
  aws_route53_record.cert_validation : record.fqdn]

  depends_on = [aws_route53_record.cert_validation]
}