# AI Skills Academy — One-Command Installer (Windows PowerShell)
# Installs free AI skills, course, and resources

$ErrorActionPreference = "Stop"

$REPO = "divolax/ai-skills-academy"
$REPO_URL = "https://github.com/$REPO.git"
$INSTALL_DIR = "$env:USERPROFILE\.ai-skills-academy"
$SKILL_DIR = "$env:USERPROFILE\.claude\commands\ai"

Write-Host ""
Write-Host "  AI Skills Academy"
Write-Host "  =================="
Write-Host ""

# Check for Claude Code
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host "  Claude Code is not installed yet."
    Write-Host ""
    Write-Host "  Copy and paste this into PowerShell to install it:"
    Write-Host ""
    Write-Host "    irm https://claude.ai/install.ps1 | iex"
    Write-Host ""
    Write-Host "  Then run this installer again:"
    Write-Host ""
    Write-Host "    irm https://raw.githubusercontent.com/$REPO/main/install.ps1 | iex"
    Write-Host ""
    Write-Host "  Need help? Write to @dima_aikit_bot"
    Write-Host ""
    exit 0
}

Write-Host "  Claude Code detected"
Write-Host ""

# Clone or update the repo
if (Test-Path $INSTALL_DIR) {
    Write-Host "  Updating existing installation..."
    Set-Location $INSTALL_DIR
    git pull --quiet origin main
    Write-Host "  Updated to latest version."
} else {
    Write-Host "  Downloading AI Skills Academy..."
    git clone --quiet $REPO_URL $INSTALL_DIR
    Write-Host "  Downloaded."
}

Write-Host ""

# Install skills to Claude Code
Write-Host "  Installing skills..."
if (-not (Test-Path $SKILL_DIR)) {
    New-Item -ItemType Directory -Force -Path $SKILL_DIR | Out-Null
}

$SKILL_COUNT = 0
Get-ChildItem -Path "$INSTALL_DIR\skills\" -Filter "*.md" | ForEach-Object {
    Copy-Item $_.FullName -Destination $SKILL_DIR
    $SKILL_NAME = $_.BaseName
    Write-Host "    ✓ /ai:$SKILL_NAME"
    $SKILL_COUNT++
}

if ($SKILL_COUNT -eq 0) {
    Write-Host "    No skills found."
} else {
    Write-Host "  $SKILL_COUNT skill(s) installed."
}

Write-Host ""

# Summary
Write-Host "  Done!"
Write-Host ""
Write-Host "  What was installed:"
Write-Host "  ├── Skills → ~/.claude/commands/ai/"
Write-Host "  ├── Course → ~/.ai-skills-academy/course/"
Write-Host "  ├── Gifts → ~/.ai-skills-academy/gifts/"
Write-Host "  └── CLAUDE.md Templates → ~/.ai-skills-academy/claude-md-templates/"
Write-Host ""
Write-Host "  To get updates, just re-run this command."
Write-Host ""
Write-Host "  Ready! Now just type:"
Write-Host ""
Write-Host "    claude"
Write-Host ""
Write-Host "  Then type:  /ai:start"
Write-Host ""
Write-Host "  Get bonuses in Telegram: https://t.me/dima_aikit_bot"
Write-Host ""

