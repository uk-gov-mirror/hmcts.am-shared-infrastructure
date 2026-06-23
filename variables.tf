//SHARED VARIABLES
variable "product" {
  type        = string
  default     = "am"
  description = "Access Management"
}

variable "component" {
  type        = string
  default     = "shared"
  description = "Access Management"
}

variable "env" {
  type        = string
  description = "The deployment environment (sandbox, aat, prod etc..)"
}

variable "location" {
  type        = string
  default     = "UK South"
  description = "The location where you would like to deploy your infrastructure"
}

variable "tenant_id" {
  type        = string
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. This is usually sourced from environment variables and not normally required to be specified."
}

variable "jenkins_AAD_objectId" {
  type        = string
  description = "(Required) The Azure AD object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies."
}

variable "product_group_object_id" {
  type        = string
  default     = "3e235565-1054-4b83-86c1-318d05dd4342"
  description = "dcd_group_accessmanagement_v2"
}

variable "appinsights_location" {
  type        = string
  default     = "UK South"
  description = "Location for Application Insights"
}

variable "application_type" {
  type        = string
  default     = "web"
  description = "Type of Application Insights (Web/Other)"
}

// TAG SPECIFIC VARIABLES
variable "team_contact" {
  type        = string
  description = "The name of your Slack channel people can use to contact your team about your infrastructure"
  default     = "#am-team"
}

variable "common_tags" {
  type = map(any)
}

variable "additional_managed_identities_access" {
  type        = list(string)
  description = "The name of your application"
  default     = []
}

variable "sampling_percentage" {
  description = "Specifies the sampling percentage for Application Insights.Defaults to 100% for perftest and 1% for all other environments."
  type        = number
  default     = null
}
