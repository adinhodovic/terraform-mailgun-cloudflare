module "mailgun_cloudflare" {
  source = "github.com/adinhodovic/terraform-mailgun-cloudflare"

  mailgun_domain = "mg.example.com"
  zone_id        = "my-zone"
  # Can't exceed 32 chars.
  smtp_password = "very_secret"
  spam_action   = "tag"
}
