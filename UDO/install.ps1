# UDO v4.5 Installer
# Universal Dynamic Orchestrator - PowerShell version

param(
    [switch]$Update,
    [switch]$Fresh,
    [switch]$Help
)

$ErrorActionPreference = "Stop"
$VERSION = "4.5"
$REPO_URL = "https://raw.githubusercontent.com/carderel/Ultimate-UDO/main/UDO"
$UDO_DIR = "UDO"

if ($Help) {
    Write-Host "UDO v$VERSION Installer"
    Write-Host ""
    Write-Host "Usage: .\install.ps1 [OPTIONS]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Update    Update core files only (preserves project data)"
    Write-Host "  -Fresh     Fresh install (removes existing UDO data)"
    Write-Host "  -Help      Show this help message"
    exit 0
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║         UDO - Universal Dynamic Orchestrator v$VERSION         ║" -ForegroundColor Cyan
Write-Host "║              AI Project Management System                  ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Function to get installed version
function Get-InstalledVersion {
    if (Test-Path "$UDO_DIR\.udo-version") {
        return (Get-Content "$UDO_DIR\.udo-version" -Raw).Trim()
    }
    elseif (Test-Path "$UDO_DIR\PROJECT_META.json") {
        try {
            $meta = Get-Content "$UDO_DIR\PROJECT_META.json" | ConvertFrom-Json
            return $meta.udo_version
        } catch {
            return "unknown"
        }
    }
    return "unknown"
}

# Function to download file
function Download-File {
    param([string]$RemotePath, [string]$LocalPath)
    try {
        $url = "$REPO_URL/template/$RemotePath"
        Invoke-WebRequest -Uri $url -OutFile $LocalPath -UseBasicParsing -ErrorAction Stop
        return $true
    } catch {
        Write-Host "  Warning: Could not download $RemotePath" -ForegroundColor Yellow
        return $false
    }
}

# Function to download if missing
function Download-IfMissing {
    param([string]$RemotePath, [string]$LocalPath)
    if (-not (Test-Path $LocalPath)) {
        Download-File $RemotePath $LocalPath
    } else {
        Write-Host "  Kept existing: $LocalPath" -ForegroundColor Blue
    }
}

$UpdateMode = ""

# Check if UDO is already installed
if ((Test-Path "$UDO_DIR\ORCHESTRATOR.md") -or (Test-Path "$UDO_DIR\START_HERE.md")) {
    $InstalledVersion = Get-InstalledVersion
    
    Write-Host "UDO is already installed in this directory." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Installed version: $InstalledVersion" -ForegroundColor Blue
    Write-Host "  Latest version:    $VERSION" -ForegroundColor Blue
    Write-Host ""
    
    # Check if update available
    if ($InstalledVersion -ne $VERSION) {
        Write-Host "Update available!" -ForegroundColor Green
        Write-Host ""
    }
    
    # If flags provided, use them
    if ($Update) {
        $UpdateMode = "update"
    }
    elseif ($Fresh) {
        $UpdateMode = "fresh"
    }
    else {
        # Interactive prompt
        Write-Host "What would you like to do?"
        Write-Host ""
        Write-Host "  1) Update - Refresh system files, keep your data"
        Write-Host "  2) Fresh install - Start over (removes UDO project data)"
        Write-Host "  3) Skip this time"
        Write-Host ""
        $choice = Read-Host "Choice [1/2/3]"
        
        switch ($choice) {
            "1" { $UpdateMode = "update" }
            "2" { $UpdateMode = "fresh" }
            "3" { 
                Write-Host "Skipped." -ForegroundColor Yellow
                exit 0 
            }
            default {
                Write-Host "Invalid choice. Skipped." -ForegroundColor Yellow
                exit 0
            }
        }
    }
    
    # Handle fresh install - remove existing UDO folder
    if ($UpdateMode -eq "fresh") {
        Write-Host "Removing existing UDO installation..." -ForegroundColor Red
        Remove-Item -Recurse -Force $UDO_DIR -ErrorAction SilentlyContinue
    }
}
else {
    # No existing installation
    if (-not $UpdateMode) {
        $UpdateMode = "fresh"
    }
}

Write-Host ""
Write-Host "Installing UDO v$VERSION to: $(Get-Location)\$UDO_DIR"
Write-Host "Mode: $UpdateMode" -ForegroundColor Blue
Write-Host ""

# Create UDO directory
if (-not (Test-Path $UDO_DIR)) {
    New-Item -ItemType Directory -Path $UDO_DIR -Force | Out-Null
}

# Change to UDO directory
Push-Location $UDO_DIR

# Create directories
Write-Host "Creating directory structure..."
$directories = @(
    ".agents\_archive",
    ".checkpoints",
    ".inputs",
    ".memory\canonical", ".memory\working", ".memory\disposable",
    ".outputs\_drafts",
    ".project-catalog\sessions", ".project-catalog\decisions", ".project-catalog\agents",
    ".project-catalog\errors", ".project-catalog\handoffs", ".project-catalog\archive",
    ".rules",
    ".templates",
    ".tools\adapters", ".tools\installed", ".tools\templates",
    ".takeover\agent-templates", ".takeover\audits", ".takeover\evidence"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
}

# Core files (always update)
Write-Host "Downloading core files..."
$coreFiles = @(
    "START_HERE.md", "ORCHESTRATOR.md", "COMMANDS.md", "OVERSIGHT_DASHBOARD.md", 
    "HANDOFF_PROMPT.md", "REASONING_CONTRACT.md", "DEVILS_ADVOCATE.md", 
    "AUDIENCE_ANTICIPATION.md", "TOOLS_REGISTRY.md"
)
foreach ($file in $coreFiles) {
    Download-File $file $file | Out-Null
}

# Config files
$configFiles = @(
    "HARD_STOPS.md", "LESSONS_LEARNED.md", "NON_GOALS.md", 
    "PROJECT_STATE.json", "PROJECT_META.json", "CAPABILITIES.json"
)

if ($UpdateMode -eq "fresh") {
    Write-Host "Downloading configuration files..."
    foreach ($file in $configFiles) {
        Download-File $file $file | Out-Null
    }
} else {
    Write-Host "Preserving existing configuration files..."
    foreach ($file in $configFiles) {
        Download-IfMissing $file $file
    }
}

# Templates (always update)
Write-Host "Downloading templates..."
Download-File ".templates/agent.md" ".templates\agent.md" | Out-Null
Download-File ".templates/reasoning-handoff.md" ".templates\reasoning-handoff.md" | Out-Null
Download-File ".templates/session.md" ".templates\session.md" | Out-Null
Download-File ".templates/handoff.md" ".templates\handoff.md" | Out-Null
Download-File ".templates/error.md" ".templates\error.md" | Out-Null
Download-File ".templates/canonical-fact.md" ".templates\canonical-fact.md" | Out-Null
Download-File ".templates/archive-summary.md" ".templates\archive-summary.md" | Out-Null

# Tool system files (always update)
Write-Host "Downloading tool system files..."
Download-File ".tools/adapters/search.md" ".tools\adapters\search.md" | Out-Null
Download-File ".tools/adapters/storage.md" ".tools\adapters\storage.md" | Out-Null
Download-File ".tools/adapters/data.md" ".tools\adapters\data.md" | Out-Null
Download-File ".tools/adapters/communication.md" ".tools\adapters\communication.md" | Out-Null
Download-File ".tools/adapters/execution.md" ".tools\adapters\execution.md" | Out-Null
Download-File ".tools/templates/tool-config.md" ".tools\templates\tool-config.md" | Out-Null

# Takeover module (always update)
Write-Host "Downloading takeover module..."
Download-File ".takeover/TAKEOVER_ORCHESTRATOR.md" ".takeover\TAKEOVER_ORCHESTRATOR.md" | Out-Null
Download-File ".takeover/discovery.json" ".takeover\discovery.json" | Out-Null
Download-File ".takeover/scope-config.json" ".takeover\scope-config.json" | Out-Null
Download-File ".takeover/agent-templates/structure-auditor.md" ".takeover\agent-templates\structure-auditor.md" | Out-Null
Download-File ".takeover/agent-templates/documentation-auditor.md" ".takeover\agent-templates\documentation-auditor.md" | Out-Null
Download-File ".takeover/agent-templates/code-quality-auditor.md" ".takeover\agent-templates\code-quality-auditor.md" | Out-Null
Download-File ".takeover/agent-templates/security-auditor.md" ".takeover\agent-templates\security-auditor.md" | Out-Null
Download-File ".takeover/agent-templates/test-auditor.md" ".takeover\agent-templates\test-auditor.md" | Out-Null

# Default rules (always update)
Write-Host "Downloading default rules..."
Download-File ".rules/code-standards.md" ".rules\code-standards.md" | Out-Null
Download-File ".rules/content-guidelines.md" ".rules\content-guidelines.md" | Out-Null
Download-File ".rules/data-validation.md" ".rules\data-validation.md" | Out-Null

# README files (always update)
Write-Host "Downloading documentation..."
Download-File ".memory/README.md" ".memory\README.md" | Out-Null
Download-File ".project-catalog/README.md" ".project-catalog\README.md" | Out-Null
Download-File ".project-catalog/sessions/README.md" ".project-catalog\sessions\README.md" | Out-Null

# Manifest
if ($UpdateMode -eq "fresh") {
    Download-File ".inputs/manifest.json" ".inputs\manifest.json" | Out-Null
} else {
    Download-IfMissing ".inputs/manifest.json" ".inputs\manifest.json"
}

# Create .gitkeep files
Write-Host "Ensuring directory placeholders..."
$gitkeepDirs = @(
    ".agents\_archive", ".checkpoints", ".memory\canonical", ".memory\working", 
    ".memory\disposable", ".outputs\_drafts", ".project-catalog\sessions", 
    ".project-catalog\decisions", ".project-catalog\agents", ".project-catalog\errors",
    ".project-catalog\handoffs", ".project-catalog\archive", ".tools\installed",
    ".takeover\audits", ".takeover\evidence"
)

foreach ($dir in $gitkeepDirs) {
    $gitkeep = "$dir\.gitkeep"
    if (-not (Test-Path $gitkeep)) {
        "# This file preserves the directory in git" | Out-File -FilePath $gitkeep -Encoding UTF8
    }
}

# Save version file
$VERSION | Out-File -FilePath ".udo-version" -Encoding UTF8 -NoNewline

# Update version in PROJECT_META.json
if (Test-Path "PROJECT_META.json") {
    try {
        $meta = Get-Content "PROJECT_META.json" -Raw | ConvertFrom-Json
        $meta.udo_version = $VERSION
        $meta | ConvertTo-Json -Depth 10 | Set-Content "PROJECT_META.json" -Encoding UTF8
    } catch { }
}

# Return to original directory
Pop-Location

Write-Host ""
if ($UpdateMode -eq "fresh") {
    Write-Host "✓ UDO v$VERSION installed successfully!" -ForegroundColor Green
} else {
    Write-Host "✓ UDO updated to v$VERSION!" -ForegroundColor Green
    Write-Host "  Your project data and configuration were preserved." -ForegroundColor Blue
}

Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Configure your AI with this system prompt addition:"
Write-Host ""
Write-Host "   Before responding to any request, read the project's" -ForegroundColor Yellow
Write-Host "   UDO/START_HERE.md and follow its instructions." -ForegroundColor Yellow
Write-Host ""
Write-Host '2. Tell your AI: "Read UDO/START_HERE.md and begin"'