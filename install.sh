#!/bin/bash
# AI Skills Academy — One-Command Installer
# Installs free AI skills, course, and resources

set -e

REPO="divolax/ai-skills-academy"
REPO_URL="https://github.com/${REPO}.git"
INSTALL_DIR="$HOME/.ai-skills-academy"
SKILL_DIR="$HOME/.claude/commands/ai"

echo ""
echo "  AI Skills Academy"
echo "  =================="
echo ""

# Check for Claude Code
for dir in "$HOME/.local/bin" "$HOME/.claude/local/bin" "/usr/local/bin"; do
    if [ -d "$dir" ] && [[ ":${PATH}:" != *":${dir}:"* ]]; then
        export PATH="${dir}:${PATH}"
    fi
done

if ! command -v claude &> /dev/null; then
    echo "  Claude Code is not installed yet."
    echo ""
    echo "  Copy and paste this into your terminal to install it:"
    echo ""
    echo "    curl -fsSL https://claude.ai/install.sh | bash"
    echo ""
    echo "  Then run this installer again:"
    echo ""
    echo "    curl -fsSL https://raw.githubusercontent.com/${REPO}/main/install.sh | bash"
    echo ""
    echo "  Need help? Write to @dima_aikit_bot"
    echo ""
    exit 0
fi

echo "  Claude Code detected"
echo ""

# Clone or update the repo
if [ -d "$INSTALL_DIR" ]; then
    echo "  Updating existing installation..."
    cd "$INSTALL_DIR"
    git pull --quiet origin main
    echo "  Updated to latest version."
else
    echo "  Downloading AI Skills Academy..."
    git clone --quiet "$REPO_URL" "$INSTALL_DIR"
    echo "  Downloaded."
fi

echo ""

# Install skills to Claude Code
echo "  Installing skills..."
mkdir -p "$SKILL_DIR"

SKILL_COUNT=0
for skill_file in "$INSTALL_DIR/skills/"*.md; do
    if [ -f "$skill_file" ]; then
        cp "$skill_file" "$SKILL_DIR/"
        SKILL_NAME=$(basename "$skill_file" .md)
        echo "    ✓ /ai:${SKILL_NAME}"
        SKILL_COUNT=$((SKILL_COUNT + 1))
    fi
done

if [ "$SKILL_COUNT" -eq 0 ]; then
    echo "    No skills found."
else
    echo "  ${SKILL_COUNT} skill(s) installed."
fi

echo ""

# Summary
echo "  Done!"
echo ""
echo "  What was installed:"
echo "  ├── Skills → ~/.claude/commands/ai/"
echo "  ├── Course → ~/.ai-skills-academy/course/"
echo "  ├── Gifts → ~/.ai-skills-academy/gifts/"
echo "  └── CLAUDE.md Templates → ~/.ai-skills-academy/claude-md-templates/"
echo ""
echo "  To get updates, just re-run this command."
echo ""
echo "  Ready! Now just type:"
echo ""
echo "    claude"
echo ""
echo "  Then type:  /ai:start"
echo ""
echo "  Get bonuses in Telegram: https://t.me/dima_aikit_bot"
echo ""

