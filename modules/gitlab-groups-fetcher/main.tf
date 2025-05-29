data "gitlab_groups" "all" {
  top_level_only = true
  sort           = "asc"
  order_by       = "name"
}