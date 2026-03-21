# Container Build Workflows

This repository uses GitHub Actions to build and publish container images to GitHub Container Registry (GHCR).

## Workflows

### 1. Build (`build.yml`)

**Triggers:**
- Pull requests to `main` branch
- Pushes to `main` branch

**Behavior:**
- Each container has a dedicated job that only runs when its files change
- Uses `dorny/paths-filter` to detect changes per container
- Builds only the containers that have changed
- Saves images as artifacts (30-day retention)
- **Does NOT push to registry** (build-only)

**Path Detection:**
- Jobs only trigger when files in the container's directory change
- Workflow file changes trigger all jobs
- Skips unchanged containers for faster CI

### 2. Promote (`promote.yml`)

**Trigger:** Manual (`workflow_dispatch`)

**Inputs:**
- **container**: Name of the container directory (e.g., `picoclaw`)
- **tag**: Tag to apply (e.g., `v1.0.0`, `stable`, `production`)
- **ref**: Git ref to build from (branch, tag, or commit SHA; defaults to `main`)

**Behavior:**
- Builds the specified container from the selected ref
- Pushes to GHCR with the specified tag
- Also tags with the short Git SHA

## Usage

### Automated Builds

Just open a PR or push to `main`. The build workflow will:
1. Check which container directories have changed
2. Run build jobs only for those containers
3. Store artifacts for inspection

### Promoting a Build

1. Go to **Actions** → **Promote Container**
2. Click **Run workflow**
3. Enter:
   - Container name (directory name, e.g., `picoclaw`)
   - Tag (e.g., `v1.2.3` or `stable`)
   - Ref (optional, defaults to `main`)
4. Click **Run workflow**

The image will be published to:
```
ghcr.io/{owner}/{repo}/{container}:{tag}
```

## Adding a New Container

1. Create a new directory at the repository root
2. Add a `Dockerfile` inside it
3. Update `.github/workflows/build.yml`:
   - Add the container name to the `changes` job outputs
   - Add path filter rules for the new container
   - Add a new build job (copy `build-picoclaw` and rename)
4. Commit and push

## Required Permissions

Ensure the workflow has `packages: write` permission for promotion:
- Go to **Settings** → **Actions** → **General**
- Under **Workflow permissions**, select **Read and write permissions**
- Or enable **Allow GitHub Actions to create and approve pull requests** if needed
