variable "repository" {
  type = string
}
variable "branch" {
  type = string
}
variable "path" {
  type = string
}
variable "commit_user" {
  type = object({
    name  = string
    email = string
  })
}
variable "root_namespace" {
  type = string
}
