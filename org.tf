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

resource "github_repository_file" "security_policy" {
    repository          = github_repository.example.name
    branch              = "main"
    file                = "SECURITY.md"
    content             = <<EOF
# Security Policy

This repository follows the security policy outlined below:

- Security vulnerabilities should be reported by opening an issue.
- For sensitive security-related matters, please contact our security team at security@example.com.

EOF
    commit_message      = "Add SECURITY.md"
    commit_author       = "CEDRIC DERUE"
    commit_email        = "cedric.derue@hashicaps.com"
    overwrite_on_create = true
}

resource "github_repository_file" "code_of_conduct" {
    repository          = github_repository.example.name
    branch              = "main"
    file                = "CODE_OF_CONDUCT.md"
    content             = <<EOF
# Code of Conduct

We expect all contributors to adhere to our code of conduct when participating in our project.

Please refer to the full version of our code of conduct [here](https://example.com/code-of-conduct).

EOF
    commit_message      = "Add CODE_OF_CONDUCT.md"
    commit_author       = "CEDRIC DERUE"
    commit_email        = "cedric.derue@hashicaps.com"
    overwrite_on_create = true
}

resource "github_branch_protection_v3" "example" {
  repository     = github_repository.example.name
  branch         = "main"
  require_signed_commits = true
}

resource "github_repository_dispatch" "dependabot" {
    repository = github_repository.example.name
    event_type = "dependabot"
}

resource "github_workflow" "dependabot" {
    repository = github_repository.example.name
    name       = "Dependabot"
    on         = "repository_dispatch"
    resolves   = ["dependabot"]
}

resource "github_workflow_run" "dependabot" {
    repository = github_repository.example.name
    workflow   = github_workflow.dependabot.id
    event      = "repository_dispatch"
    branch     = "main"
    ref        = "refs/heads/main"
}