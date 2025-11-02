# Continuous Integration and Branch Protection
#
# This file manages branch protection rules and CI/CD requirements for the repository.

# ============================================================================
# Local Variables
# ============================================================================

locals {
  # Branch protection configuration for main branch
  main_branch_status_checks = {
    strict   = true # Require branches to be up to date before merging
    contexts = []   # Add required status check contexts here (e.g., CI/CD checks)
    # Example: contexts = ["ci/tests", "ci/lint"]
  }
}

# ============================================================================
# Branch Protection Rules
# ============================================================================
#
# Branch protection provides quality control by preventing direct pushes to
# important branches (like main). Requires pull requests for all changes.
#

resource "github_branch_protection" "main" {
  repository_id = github_repository.backend_advanced_material.node_id

  pattern                         = "main"
  enforce_admins                  = false # Are admins exempt from branch protection rules?
  allows_deletions                = false # Prevent branch deletion
  allows_force_pushes             = false # Prevent force pushes
  require_conversation_resolution = true  # Require all conversations to be resolved before merge
  required_linear_history         = true  # Require a linear history (no merge commits)

  # Require pull request reviews
  required_pull_request_reviews {
    required_approving_review_count = 0     # Number of approvals required
    dismiss_stale_reviews           = true  # Auto-dismiss stale reviews when new commits are pushed
    require_code_owner_reviews      = true  # Require CODEOWNERS approval (if CODEOWNERS file exists)
    require_last_push_approval      = false # Require approval from last pusher
    restrict_dismissals             = false # Only allow specified users to dismiss reviews
  }

  # Require status checks to pass before merging
  required_status_checks {
    strict   = local.main_branch_status_checks.strict
    contexts = local.main_branch_status_checks.contexts
  }

  # Restrict pushes to specific users/teams (leave empty to allow all collaborators)
  # restrict_pushes = []
}
