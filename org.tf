terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
    token = var.github_token
    owner = "hashicaps"
}


resource "github_repository" "example" {
    name        = "my-public-repo"
    description = "My public repository"
    visibility  = "public"
    auto_init = true
}

resource "github_repository_file" "example" {
  repository          = github_repository.example.name
  branch              = "main"
  file                = "README.md"
  content             = "my-public-repo"
  commit_message      = "Add README.md"
  commit_author       = "CEDRIC DERUE"
  commit_email        = "cedric.derue@hashicaps.com"
  overwrite_on_create = true
}

resource "github_repository_file" "support_policy" {
    repository          = github_repository.example.name
    branch              = "main"
    file                = "SUPPORT.md"
    content             = <<EOF
# Support Policy

This repository follows the support policy outlined below:

- Support is provided on a best-effort basis.
- Issues and pull requests are welcome.
- For urgent matters, please contact our support team at support@example.com.

EOF
    commit_message      = "Add SUPPORT.md"
    commit_author       = "CEDRIC DERUE"
    commit_email        = "cedric.derue@hashicaps.com"
    overwrite_on_create = true
}