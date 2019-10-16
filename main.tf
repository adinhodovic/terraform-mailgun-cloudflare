resource "mailgunv3_domain" "default" {
  name          = var.mailgun_domain
  spam_action   = var.spam_action
  smtp_password = var.smtp_password
}

resource "cloudflare_record" "mailgun_sending_records" {
  count   = 3
  zone_id = var.zone_id
  name    = lookup(mailgunv3_domain.default.sending_records[count.index], "name")
  value   = lookup(mailgunv3_domain.default.sending_records[count.index], "value")
  type    = lookup(mailgunv3_domain.default.sending_records[count.index], "record_type")
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "mailgun_receiving_records" {
  count   = 2
  zone_id = var.zone_id
  name    = var.mailgun_domain
  value   = lookup(mailgunv3_domain.default.receiving_records[count.index], "value")
  type    = lookup(mailgunv3_domain.default.receiving_records[count.index], "record_type")
  ttl     = 1
  proxied = false
}
