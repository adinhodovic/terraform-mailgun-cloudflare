module "mailgun_cloudflare" {
  source = "github.com/adinhodovic/terraform-cloudflare-mailgun"

  mailgun_domain    = "mg.example.come"
  cloudflare_domain = "example.com"
  smtp_password     = "very_secret"
  spam_action       = "tag"
}
