resource "github_repository" "backend_advanced_material" {
  name        = "backend-advanced-material"
  description = "Backend Advanced Material"
  visibility  = "private"

  # Features
  has_issues      = true
  has_projects    = true
  has_wiki        = true
  has_discussions = true
}

output "repository_clone_url" {
  description = "The HTTP clone URL of the repository"
  value       = github_repository.backend_advanced_material.http_clone_url
  sensitive   = false
}
