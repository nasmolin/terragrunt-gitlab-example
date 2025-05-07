output "avatar_url" {
  value = gitlab_project.this.avatar_url
}

output "empty_repo" {
  value = gitlab_project.this.empty_repo
}

output "http_url_to_repo" {
  value = gitlab_project.this.http_url_to_repo
}

output "id" {
  value = gitlab_project.this.id
}

output "path_with_namespace" {
  value = gitlab_project.this.path_with_namespace
}

output "runners_token" {
  value = gitlab_project.this.runners_token
  sensitive = true
}

output "ssh_url_to_repo" {
  value = gitlab_project.this.ssh_url_to_repo
}

output "web_url" {
  value = gitlab_project.this.web_url
}
