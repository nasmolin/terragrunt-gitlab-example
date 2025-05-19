variable "developers" {
  type    = list(string)
  default = []
}

variable "maintainers" {
  type    = list(string)
  default = []
}

variable "owners" {
  type    = list(string)
  default = []
}

variable "user_ids_map" {
  type = map(number)
}