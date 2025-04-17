terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "3.3.0"
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}

provider "azuread" {
  client_certificate_path = var.client_certificate_path
  client_id = var.client_id
  tenant_id = var.tenant_id
  client_certificate_password = var.client_certificate_password
}

provider "azurerm" {
  client_certificate_path = var.client_certificate_path
  client_id = var.client_id                            
  tenant_id = var.tenant_id                            
  client_certificate_password = var.client_cert_password
  subscription_id = var.subscription_id                
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

var "subscription_id" {
  description = "To pass subscription_id with terraform command line arguments"
}

#data "azurerm_subscription" to fetch the subscription ID
data "azurerm_subscription" "primary" {    
}

#data "azuread_user" to fetch the User ID testuser@atgensoft.com
data "azuread_user" "example" {
  user_principal_name = "testuser@atgensoft.com"
}

#Reader role is assigned to User ID in subscription ID
resource "azurerm_role_assignment" "example" {
  scope = data.azurerm_subscription.primary.id
  role_definition_name = "Reader"             
  principal_id = data.azuread_user.example.object_id
}

#To run use below command
#terraform init
#terraform apply --var=client_certificate_path="pfx_file_path" --var=client_certificate_password="client_cert_pass" --var=client_id="CLIENT_ID" --var=tenant_id="TENANT_ID" --var=subscription_id="SUBSCRIPTION_ID"
