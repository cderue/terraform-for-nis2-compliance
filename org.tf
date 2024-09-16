provider "github" {
    token = var.github_token
}

resource "github_organization" "decepticons" {
    name        = "decepticons"
    description = "GitHub organization for Decepticons"
    admin_team  = "Owners"
}