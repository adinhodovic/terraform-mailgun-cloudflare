module "mailgun_cloudflare" {
  source = "github.com/adinhodovic/terraform-cloudflare-mailgun"

  domain        = "mg.example.come"
  smtp_password = "very_secret"
  spam_action   = "tag"
}
