output "full_name" {
  value = gitlab_group.this.full_name
}

output "full_path" {
  value = gitlab_group.this.full_path
}

output "group_id" {
  value = gitlab_group.this.id
}

output "runners_token" {
  value = gitlab_group.this.runners_token
  sensitive = true
}

output "web_url" {
  value = gitlab_group.this.web_url
}