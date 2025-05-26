output "user_ids" {
  value = merge(
    {
      for email, user in gitlab_user.created : email => user.id
    },
    {
      for email, user in gitlab_user.imported : email => user.id
    }
  )
}

output "generated_passwords" {
  sensitive = true
  value = {
    for email, pwd in random_password.user : email => pwd.result
  }
}