terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "3.3.0"
    }
  }
}

var "client_certificate_path" {
  description = "To pass client_certificate_path with terraform command line arguments"
}

var "client_certificate_password" {
  description = "To pass client_certificate_password with terraform command line arguments"
}

var "client_id" {
  description = "To pass client_id with terraform command line arguments"
}

var "tenant_id" {
  description = "To pass tenant_id with terraform command line arguments"
}

provider "azuread" {
  client_certificate_path = var.client_certificate_path
  client_id = var.client_id
  tenant_id = var.tenant_id
  client_certificate_password = var.client_certificate_password
}

resource "azuread_user" "example" {
  user_principal_name = "userid@domainname"
  display_name        = "Test User"
  mail_nickname       = "userid"
  password            = "SecretP@sswd99!"
}

#To run use below command
#terraform init
#terraform apply --var=client_certificate_path="pfx_file_path" --var=client_certificate_password="client_cert_pass" --var=client_id="CLIENT_ID" --var=tenant_id="TENANT_ID"
