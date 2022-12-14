output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}

output "zone_id" {
  value = data.aws_route53_zone.dns.zone_id
}