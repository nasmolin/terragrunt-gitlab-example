> WIP!

# Terragrunt + GitLabhq/gitlab Provider Example

Пример использования Terragrunt для управления ресурсами GitLab (группами, проектами и секретами) через Terraform-модули.

---

## 📖 Описание


- **Создание группы** (`gitlab-group`): автоматическое создание группы в GitLab с настройкой CI/CD-переменныx группы.  
- **Генерацию секретов** (`secrets-generator`): генерация случайных паролей и передача их в качестве CI/CD-переменныx группы.  
- **Создание проектов** (`gitlab-project`): создание проектов внутри группы, настройка веток, protection rules.

Конфигурации Terragrunt собраны в каталоге `gitlab/App-1`, где:

1. **`terragrunt.hcl`** создаёт группу `App-1` с зависимостью от генератора секретов.  
2. В подпапках `projects/backend` и `projects/frontend` — конфигурации для двух проектов внутри группы.  

---

## 📁 Структура репозитория

```plain
.
├── LICENSE
├── README.md
├── clean_terraform.sh      # Утилита для очистки временных файлов Terraform
├── root.hcl                # Глобальная конфигурация Terragrunt (remote state + общие inputs)
├── modules/
│   ├── gitlab-group/       # Модуль Terraform для создания GitLab-группы + переменных группы
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   └── variables.tf
│   ├── secrets-generator/  # Модуль для генерации случайных секретов
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   └── variables.tf
│   └── gitlab-project/     # Модуль для создания GitLab-проекта + protection rules
│       ├── main.tf
│       ├── provider.tf
│       └── variables.tf
└── gitlab/
    └── App-1/
        ├── terragrunt.hcl               # Конфигурация для создания группы App-1
        ├── outputs.tf                   # Выводы группы (ID, URL, токены)
        ├── secrets/                     # Генерация секретов для группы
        │   ├── terragrunt.hcl
        │   └── outputs.tf
        └── projects/
            ├── backend/                 # Конфигурация проекта backend
            │   ├── terragrunt.hcl
            │   └── outputs.tf
            └── frontend/                # Конфигурация проекта frontend
                ├── terragrunt.hcl
                └── outputs.tf
```

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

После успешного выполнения:
* Сначала создастся группа App-1
* Затем — два проекта backend и frontend внутри неё
* Все секреты из `gitlab/App-1/secrets/terragrunt.hcl` сгенерируются автоматически и передадутся как переменные группы

---

## ⚙️ Описание модулей
`modules/gitlab-group`
Создаёт ресурс gitlab_group с набором переменных (gitlab_group_variable).

`modules/secrets-generator`
Генерирует случайные пароли (random_password) по конфигурации generate_secrets.

`modules/gitlab-project`
Создаёт ресурс gitlab_project, ветки (gitlab_branch), protection rules (gitlab_branch_protection, gitlab_tag_protection) и CI/CD-переменные (gitlab_project_variable).

---