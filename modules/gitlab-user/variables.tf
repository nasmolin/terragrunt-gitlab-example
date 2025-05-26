variable "users" {
  type = map(object({
    email         = string
    name          = string
    username      = string
    state         = string
    create_user   = bool
    is_admin      = bool
  }))
}