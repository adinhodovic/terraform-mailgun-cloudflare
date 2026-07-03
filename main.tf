resource "mailgun_domain" "default" {
  region        = var.region
  name          = var.mailgun_domain
  spam_action   = var.spam_action
  smtp_password = var.smtp_password

  lifecycle {
    ignore_changes = [smtp_password]
  }
}

resource "cloudflare_dns_record" "mailgun_sending_records" {
  count   = 3
  zone_id = var.zone_id
  name    = tolist(mailgun_domain.default.sending_records_set)[count.index].name
  content = tolist(mailgun_domain.default.sending_records_set)[count.index].value
  type    = tolist(mailgun_domain.default.sending_records_set)[count.index].record_type
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "mailgun_receiving_records" {
  count    = 2
  zone_id  = var.zone_id
  name     = var.mailgun_domain
  content  = tolist(mailgun_domain.default.receiving_records_set)[count.index].value
  type     = tolist(mailgun_domain.default.receiving_records_set)[count.index].record_type
  priority = tolist(mailgun_domain.default.receiving_records_set)[count.index].priority
  proxied  = false
  ttl      = 1
}
