---
name: deploy-do
description: >
  Deploy apps to DigitalOcean App Platform using the DigitalOcean MCP tools.
  Use when the user wants to deploy, update, check status, monitor, or manage
  an app on DigitalOcean. Triggers: deploy, digitalocean, DO, app platform,
  deployment status, app logs, scale app.
---

# DigitalOcean App Platform Deployment Skill

Deploy and manage apps on DigitalOcean App Platform using the MCP tools.

## Prerequisites

- The `digitalocean-apps` MCP server must be configured in Claude Code
- A valid `DIGITALOCEAN_API_TOKEN` must be set
- The project should have a `.do/app.yaml` spec file (or you'll create one)

If the MCP server is not configured, add it with:
```bash
claude mcp add --transport http digitalocean-apps \
  "https://apps.mcp.digitalocean.com/mcp" \
  --header "Authorization: Bearer $DIGITALOCEAN_API_TOKEN"
```

## Available MCP Tools

| Tool | Purpose |
|------|---------|
| `create-app-from-spec` | Create a new app from an app spec (YAML/JSON) |
| `apps-update` | Update app config and trigger redeployment |
| `apps-delete` | Delete an app |
| `apps-get-info` | Get app details and status |
| `apps-usage` | Get live CPU/memory usage |
| `apps-get-deployment-status` | Check deployment progress |
| `apps-list` | List all apps in the account |

## Deployment Workflow

### First Deploy (New App)

1. **Check for `.do/app.yaml`** in the project root
   - If missing, create one based on the project's stack (see App Spec Templates below)
   - Ensure the GitHub repo, branch, build/run commands, and env vars are correct

2. **Verify GitHub repo access**
   - The repo must be connected to DigitalOcean (GitHub app installation)
   - The repo name in the spec must match exactly (org/repo format)

3. **Create the app** using `create-app-from-spec`
   - Pass the contents of `.do/app.yaml` as the spec
   - Monitor deployment with `apps-get-deployment-status`

4. **Verify deployment**
   - Use `apps-get-info` to get the live URL
   - Check deployment status is "ACTIVE"

### Update Existing App

1. Use `apps-get-info` to check current state
2. Use `apps-update` to modify config (env vars, scaling, branch, etc.)
3. Monitor with `apps-get-deployment-status`

### Check Status

1. `apps-list` to find the app
2. `apps-get-info` for details
3. `apps-usage` for resource monitoring
4. `apps-get-deployment-status` for deploy progress

## App Spec Templates

### Next.js App
```yaml
name: app-name
region: nyc
services:
  - name: web
    github:
      repo: org/repo
      branch: main
      deploy_on_push: true
    build_command: npm run build
    run_command: npm start
    environment_slug: node-js
    instance_size_slug: apps-s-1vcpu-0.5gb
    instance_count: 1
    http_port: 3000
    routes:
      - path: /
    envs:
      - key: NODE_ENV
        value: "production"
        scope: RUN_AND_BUILD_TIME
```

### Static Site (Vite, CRA, etc.)
```yaml
name: app-name
region: nyc
static_sites:
  - name: web
    github:
      repo: org/repo
      branch: main
      deploy_on_push: true
    build_command: npm run build
    output_dir: dist
    environment_slug: node-js
    routes:
      - path: /
```

### Go / Python / Other Backend
```yaml
name: app-name
region: nyc
services:
  - name: api
    github:
      repo: org/repo
      branch: main
      deploy_on_push: true
    build_command: go build -o bin/server
    run_command: bin/server
    environment_slug: go
    instance_size_slug: apps-s-1vcpu-0.5gb
    instance_count: 1
    http_port: 8080
    routes:
      - path: /
```

## Common Issues

- **"repo not found"**: The GitHub App for DigitalOcean needs to be installed on the repo/org
- **Build failures**: Check that `build_command` and `run_command` match what's in `package.json` (or equivalent)
- **Port mismatch**: Ensure `http_port` matches what the app actually listens on
- **Env vars missing**: Add all required env vars to the `envs` section with appropriate `scope` (BUILD_TIME, RUN_TIME, or RUN_AND_BUILD_TIME)

## Decision Framework

1. **"Deploy this app"** -> Check for `.do/app.yaml`, create if missing, use `create-app-from-spec`
2. **"Update the deployment"** -> Use `apps-update` with modified spec
3. **"Check deployment status"** -> Use `apps-get-deployment-status` or `apps-get-info`
4. **"How's the app doing?"** -> Use `apps-usage` for resources, `apps-get-info` for status
5. **"Delete the app"** -> Confirm with user first, then `apps-delete`
6. **"Scale up"** -> Use `apps-update` to change `instance_size_slug` or `instance_count`
