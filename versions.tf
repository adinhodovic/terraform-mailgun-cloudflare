terraform {
  required_providers {
    cloudflare = {
      source = "terraform-providers/cloudflare"
    }
    mailgunv3 = {
      # TF-UPGRADE-TODO
      #
      # No source detected for this provider. You must add a source address
      # in the following format:
      #
      # source = "your-registry.example.com/organization/mailgunv3"
      #
      # For more information, see the provider source documentation:
      #
      # https://www.terraform.io/docs/configuration/providers.html#provider-source
    }
  }
  required_version = ">= 0.13"
}
