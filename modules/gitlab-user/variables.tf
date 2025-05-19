variable "users" {
  type = map(object({
    email    = string
    name     = string
    username = string
    state    = string
  }))
}