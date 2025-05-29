output "groups" {
  description = "List of GitLab groups"
  value       = data.gitlab_groups.all.groups
}