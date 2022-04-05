resource "mailgun_domain" "default" {
  region        = var.region
  name          = var.mailgun_domain
  spam_action   = var.spam_action
  smtp_password = var.smtp_password

  lifecycle {
    ignore_changes = [smtp_password]
  }
}

resource "cloudflare_record" "mailgun_sending_records" {
  count   = 3
  zone_id = var.zone_id
  name    = lookup(mailgun_domain.default.sending_records[count.index], "name")
  value   = lookup(mailgun_domain.default.sending_records[count.index], "value")
  type    = lookup(mailgun_domain.default.sending_records[count.index], "record_type")
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "mailgun_receiving_records" {
  count   = 2
  zone_id = var.zone_id
  name    = var.mailgun_domain
  value   = lookup(mailgun_domain.default.receiving_records[count.index], "value")
  type    = lookup(mailgun_domain.default.receiving_records[count.index], "record_type")
  ttl     = 1
  proxied = false
}
