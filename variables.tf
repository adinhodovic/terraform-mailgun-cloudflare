variable "cloudflare_domain" {
  type = string
}

variable "mailgun_domain" {
  type = string
}

variable "smtp_password" {
  type = string
}

variable "spam_action" {
  type    = string
  default = "disabled"
}
