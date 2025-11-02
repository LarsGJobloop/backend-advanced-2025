# Commit Message Conventions

This project follows a structured commit message format to maintain clear and consistent version history.

## Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

## Type

The type must be one of the following:

- **feat**: A new feature
- **fix**: A bug fix
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **docs**: Documentation only changes
- **chore**: Changes to build process or auxiliary tools

## Scope

The scope should be a project-specific label indicating the area of the codebase affected:

- **canvas**: Canvas LMS integration and publishing
- **content**: Content material (markdown files, course material)
- **build**: Build configuration and tooling
- **config**: Configuration files and settings
- **scripts**: Automation scripts and workflows

## Subject

- Use imperative, present tense: "change" not "changed" nor "changes"
- Don't capitalize the first letter
- No period (.) at the end

## Body (Optional)

- Use the imperative, present tense
- Include motivation for the change and contrasts with previous behavior
- Wrap at 72 characters

## Examples

```
feat(canvas): add support for batch page updates

Implement batch update functionality to reduce API calls
when syncing multiple Canvas pages simultaneously.

refactor(canvas): extract Canvas API calls into reusable module

- Create canvas.just module with parameterized API recipes
- Extract stable configuration to top-level variables
- Move course_id configuration to main justfile
- Improves maintainability and prepares for SDK migration

fix(build): correct Nix flake dependency version

docs(content): add timeplan for IaC module

chore(config): update Canvas course ID to 516
```

## Git Commit Template

To use the commit template, configure git:

```bash
git config --local commit.template .gitmessage
```

This will configure the template for this repository only (using `--local` to avoid overwriting global git settings). Then use `git commit` and the template will be loaded automatically.
