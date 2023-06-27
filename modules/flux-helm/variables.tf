################################################################################
# FLUX
################################################################################
variable "flux_path" {
  description = "Flux git repo path"
  type        = string
}
variable "git_url" {
  description = "GIT URL"
  type        = string
}
variable "git_user" {
  description = "GIT User"
  type        = string
  default     = "demo"
}
variable "git_token" {
  description = "GIT Token"
  type        = string
}
