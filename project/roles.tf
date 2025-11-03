# Repository Roles and Collaborators
#
# This file manages repository collaborators and their permission levels.

# ============================================================================
# Local Variables
# ============================================================================

locals {
  # Repository administrators - full access including settings
  admins = [
    "LarsGJobloop",
    "JorgenMJobloop"
  ]
}

# ============================================================================
# Repository Collaborators
# ============================================================================

# Admins - full repository access
resource "github_repository_collaborator" "admins" {
  for_each = toset(local.admins)

  repository = github_repository.backend_advanced_material.name
  username   = each.value
  permission = "admin"
}
