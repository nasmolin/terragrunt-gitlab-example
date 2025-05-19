output "user_ids" {
  value = {
    for email, user in gitlab_user.this : email => user.id
  }
}

output "generated_passwords" {
  sensitive = true
  value = {
    for email, pwd in random_password.user : email => pwd.result
  }
}