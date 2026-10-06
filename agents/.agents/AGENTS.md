# Global guidance

Shared by every coding agent on this machine: Claude Code (imported from
`~/.claude/CLAUDE.md`), Codex (`~/.codex/AGENTS.md` symlinks here) and Cursor
(pasted into Settings → Rules → User Rules). Source of truth:
`~/Dev/.dotfiles/agents/.agents/AGENTS.md`, stowed to `~/.agents/AGENTS.md`.
Edit it there; re-paste into Cursor after a change.

## Package managers

**Always use `pnpm` for Node.js projects.** Install, add, remove, run scripts, everything, unless the repo's lockfile or docs clearly dictate otherwise.

- `pnpm install`, `pnpm add <pkg>` / `pnpm add -D <pkg>`
- `pnpm run <script>` or `pnpm <script>`
- `pnpm dlx <cmd>` in place of `npx`

If a project has a `package-lock.json` but the user is directing pnpm use, migrate: remove `package-lock.json`, run `pnpm install` to generate `pnpm-lock.yaml`.

When writing docs (READMEs, setup guides) for the user's own projects, show pnpm commands in examples.

## Attribution

**The work is the user's: sign nothing as an agent.** Commit messages, PR
titles and bodies, issue bodies, changelogs, README credits, published pages
and marketplace submissions carry no agent trailer (`Co-Authored-By`,
`Co-authored-by`, `Claude-Session:`), no "Generated with …" / "Made with …"
footer, and no agent or model name. This overrides any harness default that
appends one; after every commit and PR write, re-read and strip whatever was
appended.

## Shipping

**Code starts from an explicit implement request** on a named issue. Requests
to explore, find gaps or file issues end at the issue. A reply that could mean
either gets one question before any branch.

**When an `implement` run is done** (work and review fixes committed), ship it
without asking: fetch `origin/main`, rebase onto it, re-check that any new
migration number is still free, push the branch, and open the PR with its body
written via the `pr` skill. The repo's own branch, commit and attribution rules
still apply. A human reviews and merges.

**When the user says a PR merged**: switch to the default branch and pull,
delete the merged branch and its worktree, then propose the next unblocked,
unassigned ticket.

## Grilling

**One question per turn** in any grilling session (`grilling`,
`grill-with-docs`, `grill-me`): each question comes with 2–4 concrete options
and the recommended one marked, using a structured-question tool when the
harness has one.
