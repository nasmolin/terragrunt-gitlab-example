# Terragrunt + GitLabhq/gitlab Provider Example

Пример использования Terragrunt для управления ресурсами GitLab (группами, пользователями, правами, проектами и секретами) через Terraform-модули.

---

## Локальный запуск

```bash
export GITLAB_API_TOKEN="..."
export GITLAB_API_URL="..."  # example: "https://gitlab.com/api/v4/"
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
```
```bash
git clone https://github.com/nasmolin/terragrunt-gitlab-example.git
```
```bash
cd terragrunt-gitlab-example
```
```bash
cat <<EOF > remote_state.hcl
remote_state {
  backend = "s3"
  
  config = {
    endpoint          = "..."
    bucket            = "..."
    key               = "\${path_relative_to_include()}/terraform.tfstate"
    region            = "..."
    dynamodb_endpoint = "..."
    dynamodb_table    = "..."
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

## Порядок выполнения модулей

```bash
Group 1
- Module ./gitlab/Codebase/App-1/secrets            # Генерация CI/CD group variables.
- Module ./gitlab/Users                             # Создание пользователей gitlab.

Group 2
- Module ./gitlab/Codebase/App-1/members            # Генерация мапы email:user_id

Group 3
- Module ./gitlab/Codebase/App-1                    # Создание группы, добавление участников и установка групповых переменных.

Group 4                                             # Создание проектов внутри группы App-1.
- Module ./gitlab/Codebase/App-1/projects/backend   
- Module ./gitlab/Codebase/App-1/projects/frontend
```

---

## Описание terraform модулей

### modules/gitlab-group

Создает ресурсы:
- GitLab-группу (`gitlab_group`)
- Групповые переменные (`gitlab_group_variable`)
- Членство пользователей в группе (`gitlab_group_membership`)

### modules/gitlab-project

Создает ресурсы:
- GitLab-проект (`gitlab_project`)
- Ветки (`gitlab_branch`)
- Правила защиты (`gitlab_branch_protection`, `gitlab_tag_protection`)

### modules/gitlab-user

Создает ресурсы:
- Пользователей GitLab (`gitlab_user`)

### modules/secrets-generator

Вспомогательный модуль.

Генерирует случайные секреты с помощью ресурса `random_password`, согласно конфигурации `generate_secrets`.

### modules/memberships-generator

Вспомогательный модуль.

Формирует необходимые переменные в `outputs` для использования в `gitlab_group_membership`.