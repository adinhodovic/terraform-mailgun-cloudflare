resource "mailgun_domain" "default" {
  region        = var.region
  name          = var.mailgun_domain
  spam_action   = var.spam_action
  smtp_password = var.smtp_password

  lifecycle {
    ignore_changes = [smtp_password]
  }
}

locals {
  sending_records = concat(
    [for record in mailgun_domain.default.sending_records_set : record if record.record_type == "TXT" && length(regexall("_domainkey", record.name)) == 0],
    [for record in mailgun_domain.default.sending_records_set : record if record.record_type == "TXT" && length(regexall("_domainkey", record.name)) > 0],
    [for record in mailgun_domain.default.sending_records_set : record if record.record_type == "CNAME"],
  )

  receiving_records = [
    for value in sort([for record in mailgun_domain.default.receiving_records_set : record.value]) :
    one([for record in mailgun_domain.default.receiving_records_set : record if record.value == value])
  ]
}

resource "cloudflare_dns_record" "mailgun_sending_records" {
  count   = 3
  zone_id = var.zone_id
  name    = local.sending_records[count.index].name
  content = local.sending_records[count.index].value
  type    = local.sending_records[count.index].record_type
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "mailgun_receiving_records" {
  count    = 2
  zone_id  = var.zone_id
  name     = var.mailgun_domain
  content  = local.receiving_records[count.index].value
  type     = local.receiving_records[count.index].record_type
  priority = local.receiving_records[count.index].priority
  proxied  = false
  ttl      = 1
}
