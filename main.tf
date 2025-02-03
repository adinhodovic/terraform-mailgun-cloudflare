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
  name    = lookup(mailgun_domain.default.sending_records[count.index], "name")
  content = lookup(mailgun_domain.default.sending_records[count.index], "value")
  type    = lookup(mailgun_domain.default.sending_records[count.index], "record_type")
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "mailgun_receiving_records" {
  count    = 2
  zone_id  = var.zone_id
  name     = var.mailgun_domain
  content  = lookup(mailgun_domain.default.receiving_records[count.index], "value")
  type     = lookup(mailgun_domain.default.receiving_records[count.index], "record_type")
  priority = lookup(mailgun_domain.default.receiving_records[count.index], "priority")
  proxied  = false
  ttl      = 1
}
