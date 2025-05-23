# Terragrunt + GitLabhq/gitlab Provider Example

Пример использования Terragrunt для управления ресурсами GitLab (группами, пользователями, правами,проектами и секретами) через Terraform-модули.

---

## 🔑 Настройка окружения

```
export GITLAB_API_TOKEN="your_personal_access_token"
export GITLAB_API_URL="https://gitlab.com/api/v4/"
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
```
---

## 🚀 Локальный запуск


```bash
git clone https://github.com/nasmolin/terragrunt-gitlab-example.git
```
```bash
cd terragrunt-gitlab-example
```
```bash
cat <<EOF >> remote_state.hcl
remote_state {
  backend = "s3"
  
  config = {
    endpoint      = "xxx"
    bucket         = "xxx"
    key            = "\${path_relative_to_include()}/terraform.tfstate"
    region         = "xxx"
    dynamodb_endpoint = "xxx"
    dynamodb_table    = "xxx"
  }
}
EOF
```
```bash
terragrunt plan -all
```
```bash
terragrunt apply -all
```

---

## ⚙️ Описание модулей
`modules/gitlab-group`
Создаёт ресурс gitlab_group с набором переменных (gitlab_group_variable), членством в группе(gitlab_group_membership).

`modules/gitlab-project`
Создаёт ресурс gitlab_project, ветки (gitlab_branch), protection rules (gitlab_branch_protection, gitlab_tag_protection) и CI/CD-переменные (gitlab_project_variable).

`modules/gitlab-user`
Создаёт ресурсы gitlab_user.

`modules/secrets-generator`
Вспомогательный модуль. Генерирует случайные пароли (random_password) по конфигурации generate_secrets.

`modules/memberships-generator`
Вспомогательный модуль. Генерирует необходимые перменные в outputs для ресурса gitlab_group_membership.
