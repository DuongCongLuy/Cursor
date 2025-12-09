#!/bin/bash

# ============================================
# Setup MCP Config from Codespaces Secrets
# ============================================

echo "Setting up MCP configuration..."

# Check if secrets are available
if [ -z "$NOTION_TOKEN" ] || [ -z "$OPENAI_API_KEY" ]; then
    echo ""
    echo "WARNING: Secrets not found!"
    echo ""
    echo "Please add secrets in GitHub:"
    echo "  1. Go to: github.com/YOUR_REPO/settings/secrets/codespaces"
    echo "  2. Add: NOTION_TOKEN (your Notion integration token)"
    echo "  3. Add: OPENAI_API_KEY (your OpenAI API key)"
    echo ""
    echo "Then rebuild this Codespace."
    echo ""

    # Create template file for reference
    cat > .mcp.json.template << 'EOF'
{
  "mcpServers": {
    "notionApi": {
      "command": "npx",
      "args": ["-y", "@notionhq/notion-mcp-server"],
      "env": {
        "NOTION_TOKEN": "YOUR_NOTION_TOKEN_HERE"
      }
    },
    "claude-context": {
      "command": "npx",
      "args": ["-y", "@zilliz/claude-context-mcp@latest"],
      "env": {
        "OPENAI_API_KEY": "YOUR_OPENAI_API_KEY_HERE"
      }
    }
  }
}
EOF
    echo "Created .mcp.json.template for reference."
    exit 0
fi

# Create .mcp.json with actual secrets
cat > .mcp.json << EOF
{
  "mcpServers": {
    "notionApi": {
      "command": "npx",
      "args": ["-y", "@notionhq/notion-mcp-server"],
      "env": {
        "NOTION_TOKEN": "$NOTION_TOKEN"
      }
    },
    "claude-context": {
      "command": "npx",
      "args": ["-y", "@zilliz/claude-context-mcp@latest"],
      "env": {
        "OPENAI_API_KEY": "$OPENAI_API_KEY"
      }
    }
  }
}
EOF

echo "MCP configuration created successfully!"
echo ""
echo "MCP Servers configured:"
echo "  - notionApi (Notion integration)"
echo "  - claude-context (OpenAI context)"
echo ""
echo "You can now use Claude Code with MCP support."
