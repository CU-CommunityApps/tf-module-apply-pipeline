variable "teams_webhook_url" {
  type        = string
  sensitive   = true
}

variable "github_codestarconnections_connection_arn" {
  type    = string
}

variable "namespace" {
  type    = string
}

variable "terraform_state_bucket" {
  type    = string
}

variable "terraform_state_key" {
  type    = string
}

variable "github_repo" {
  type    = string
}

variable "git_branch" {
  type    = string
  default = "main"
}

variable "environment" {
  type    = string
  default = "production"
}

variable "global_tags" {
  type    = map
  default = {}
}

variable "terraform_version" {
  type    = string
}

variable "resources_path" {
  type    = string
  default = "resources/"
}

variable "build_cron" {
  type    = string
  default = "cron(0 12 * * ? *)"
}

variable "resource_plan_policy_arns" {
  type    = list(string)
}

variable "resource_apply_policy_arns" {
  type    = list(string)
}

variable "github_webhook_enabled" {
  type    = bool
  default = false
}

variable "tf_log" {
  type    = string
  default = null
}
