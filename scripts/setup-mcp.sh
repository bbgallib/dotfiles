#!/usr/bin/env bash
set -euo pipefail

# Register MCP servers at user scope for Claude Code.
# Run once after installing Claude Code on a new machine.
# Safe to re-run: already-configured servers are skipped.

add_if_absent() {
  local name="$1"; shift
  if claude mcp list 2>/dev/null | grep -q "^${name}"; then
    echo "MCP '${name}' already configured, skipping."
    return
  fi
  echo "Adding MCP '${name}'..."
  claude mcp add --scope user "$name" "$@"
}

add_if_absent playwright          -t stdio -- npx -y @playwright/mcp@latest
add_if_absent context7            -t stdio -- npx -y @upstash/context7-mcp
add_if_absent sequential-thinking -t stdio -- npx -y @modelcontextprotocol/server-sequential-thinking
add_if_absent chrome-devtools     -t stdio -- npx -y chrome-devtools-mcp@latest

if command -v codex >/dev/null 2>&1; then
  add_if_absent codex -t stdio -- codex mcp-server
else
  echo "SKIP: codex not found (install separately if needed)"
fi

if command -v uvx >/dev/null 2>&1; then
  add_if_absent serena -t stdio -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant
else
  echo "SKIP: uvx not found (install uv separately if needed)"
fi

echo ""
echo "Notion MCP は OAuth 認証が必要なため手動で設定してください:"
echo "  claude mcp add --scope user -t sse notion https://mcp.notion.com/sse"
