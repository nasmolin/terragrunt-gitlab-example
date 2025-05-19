# Terragrunt + GitLabhq/gitlab Provider Example

Пример использования Terragrunt для управления ресурсами GitLab (группами, пользователями, правами,проектами и секретами) через Terraform-модули.

---

## 🔑 Настройка окружения

```
export GITLAB_API_TOKEN="your_personal_access_token"
export GITLAB_API_URL="https://gitlab.com/api/v4/"
```
> Важно: токен должен иметь права на создание групп и проектов.

---

## 🚀 Локальный запуск

Клонируйте репозиторий и перейдите в него:

```bash
git clone https://github.com/nasmolin/terragrunt-gitlab-example.git
cd terragrunt-gitlab-example
```

```bash
terragrunt plan -all
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
