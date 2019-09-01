locals {
  domain = "hodovi.cc"
}

resource "mailgunv3_domain" "default" {
  name          = var.domain
  spam_action   = var.spam_action
  smtp_password = var.smtp_password
}

resource "cloudflare_record" "domain_mailgun_sending_records" {
  count   = "3"
  domain  = var.domain
  name    = "${lookup(mailgunv3_domain.default.sending_records[count.index], "name")}"
  value   = "${lookup(mailgunv3_domain.default.sending_records[count.index], "value")}"
  type    = "${lookup(mailgunv3_domain.default.sending_records[count.index], "record_type")}"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "domain_mailgun_receiving_records" {
  count   = "2"
  domain  = var.domain
  name    = "${mailgunv3_domain.default.name}"
  value   = "${lookup(mailgunv3_domain.default.receiving_records[count.index], "value")}"
  type    = "${lookup(mailgunv3_domain.default.receiving_records[count.index], "record_type")}"
  ttl     = 1
  proxied = false
}
