# UDO v4.5 Installer
# Universal Dynamic Orchestrator - PowerShell version

param(
    [switch]$Update,
    [switch]$Fresh,
    [switch]$Migrate,
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
    Write-Host "  -Migrate   Migrate legacy root install to UDO/ subfolder"
    Write-Host "  -Help      Show this help message"
    exit 0
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║         UDO - Universal Dynamic Orchestrator v$VERSION         ║" -ForegroundColor Cyan
Write-Host "║              AI Project Management System                  ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

function Get-InstalledVersion {
    if (Test-Path "$UDO_DIR\.udo-version") { return (Get-Content "$UDO_DIR\.udo-version" -Raw).Trim() }
    elseif (Test-Path "$UDO_DIR\PROJECT_META.json") { try { return (Get-Content "$UDO_DIR\PROJECT_META.json" | ConvertFrom-Json).udo_version } catch { return "unknown" } }
    elseif (Test-Path ".udo-version") { return (Get-Content ".udo-version" -Raw).Trim() }
    elseif (Test-Path "PROJECT_META.json") { try { return (Get-Content "PROJECT_META.json" | ConvertFrom-Json).udo_version } catch { return "unknown" } }
    return "unknown"
}

function Migrate-LegacyInstall {
    Write-Host "Migrating legacy installation to UDO/ subfolder..." -ForegroundColor Yellow
    if (-not (Test-Path $UDO_DIR)) { New-Item -ItemType Directory -Path $UDO_DIR -Force | Out-Null }
    
    $files = @("ORCHESTRATOR.md","START_HERE.md","COMMANDS.md","OVERSIGHT_DASHBOARD.md","HANDOFF_PROMPT.md","REASONING_CONTRACT.md","DEVILS_ADVOCATE.md","AUDIENCE_ANTICIPATION.md","TOOLS_REGISTRY.md","HARD_STOPS.md","LESSONS_LEARNED.md","NON_GOALS.md","PROJECT_STATE.json","PROJECT_META.json","CAPABILITIES.json",".udo-version")
    foreach ($f in $files) { if (Test-Path $f) { Move-Item $f "$UDO_DIR\" -Force; Write-Host "  Moved: $f" -ForegroundColor Green } }
    
    $dirs = @(".agents",".checkpoints",".inputs",".memory",".outputs",".project-catalog",".rules",".templates",".tools",".takeover")
    foreach ($d in $dirs) { if (Test-Path $d) { Move-Item $d "$UDO_DIR\" -Force; Write-Host "  Moved: $d/" -ForegroundColor Green } }
    
    Write-Host "Migration complete!" -ForegroundColor Green
    Write-Host ""
}

function Download-File { param([string]$R, [string]$L); try { Invoke-WebRequest -Uri "$REPO_URL/template/$R" -OutFile $L -UseBasicParsing -ErrorAction Stop; return $true } catch { Write-Host "  Warning: Could not download $R" -ForegroundColor Yellow; return $false } }
function Download-IfMissing { param([string]$R, [string]$L); if (-not (Test-Path $L)) { Download-File $R $L } else { Write-Host "  Kept existing: $L" -ForegroundColor Blue } }

$UpdateMode = ""
$LegacyInstall = $false

if ((Test-Path "ORCHESTRATOR.md") -or (Test-Path "START_HERE.md")) { if (-not (Test-Path $UDO_DIR)) { $LegacyInstall = $true } }

if ($LegacyInstall) {
    $InstalledVersion = Get-InstalledVersion
    Write-Host "Legacy UDO installation detected (files at root level)." -ForegroundColor Yellow
    Write-Host "UDO v4.5+ uses a UDO/ subfolder for cleaner organization."
    Write-Host ""; Write-Host "  Installed version: $InstalledVersion" -ForegroundColor Blue; Write-Host "  Latest version:    $VERSION" -ForegroundColor Blue; Write-Host ""
    
    if ($Migrate) { Migrate-LegacyInstall; $UpdateMode = "update" }
    elseif ($Fresh) { $UpdateMode = "fresh" }
    else {
        Write-Host "What would you like to do?"; Write-Host ""; Write-Host "  1) Migrate - Move UDO files into UDO/ subfolder (recommended)"; Write-Host "  2) Fresh install - Keep old files, create new UDO/ folder"; Write-Host "  3) Skip"; Write-Host ""
        $choice = Read-Host "Choice [1/2/3]"
        switch ($choice) { "1" { Migrate-LegacyInstall; $UpdateMode = "update" } "2" { $UpdateMode = "fresh" } "3" { Write-Host "Skipped." -ForegroundColor Yellow; exit 0 } default { Write-Host "Invalid. Skipped." -ForegroundColor Yellow; exit 0 } }
    }
}

if ((Test-Path "$UDO_DIR\ORCHESTRATOR.md") -or (Test-Path "$UDO_DIR\START_HERE.md")) {
    $InstalledVersion = Get-InstalledVersion
    Write-Host "UDO is already installed in this directory." -ForegroundColor Yellow
    Write-Host ""; Write-Host "  Installed version: $InstalledVersion" -ForegroundColor Blue; Write-Host "  Latest version:    $VERSION" -ForegroundColor Blue; Write-Host ""
    if ($InstalledVersion -ne $VERSION) { Write-Host "Update available!" -ForegroundColor Green; Write-Host "" }
    
    if ($Update) { $UpdateMode = "update" } elseif ($Fresh) { $UpdateMode = "fresh" }
    elseif (-not $UpdateMode) {
        Write-Host "What would you like to do?"; Write-Host ""; Write-Host "  1) Update - Refresh system files, keep your data"; Write-Host "  2) Fresh install - Start over"; Write-Host "  3) Skip"; Write-Host ""
        $choice = Read-Host "Choice [1/2/3]"
        switch ($choice) { "1" { $UpdateMode = "update" } "2" { $UpdateMode = "fresh" } "3" { Write-Host "Skipped." -ForegroundColor Yellow; exit 0 } default { Write-Host "Invalid. Skipped." -ForegroundColor Yellow; exit 0 } }
    }
    if ($UpdateMode -eq "fresh") { Write-Host "Removing existing UDO installation..." -ForegroundColor Red; Remove-Item -Recurse -Force $UDO_DIR -ErrorAction SilentlyContinue }
} else { if (-not $UpdateMode) { $UpdateMode = "fresh" } }

Write-Host ""; Write-Host "Installing UDO v$VERSION to: $(Get-Location)\$UDO_DIR"; Write-Host "Mode: $UpdateMode" -ForegroundColor Blue; Write-Host ""

if (-not (Test-Path $UDO_DIR)) { New-Item -ItemType Directory -Path $UDO_DIR -Force | Out-Null }
Push-Location $UDO_DIR

Write-Host "Creating directory structure..."
@(".agents\_archive",".checkpoints",".inputs",".memory\canonical",".memory\working",".memory\disposable",".outputs\_drafts",".project-catalog\sessions",".project-catalog\decisions",".project-catalog\agents",".project-catalog\errors",".project-catalog\handoffs",".project-catalog\archive",".rules",".templates",".tools\adapters",".tools\installed",".tools\templates",".takeover\agent-templates",".takeover\audits",".takeover\evidence") | ForEach-Object { if (-not (Test-Path $_)) { New-Item -ItemType Directory -Path $_ -Force | Out-Null } }

Write-Host "Downloading core files..."
@("START_HERE.md","ORCHESTRATOR.md","COMMANDS.md","OVERSIGHT_DASHBOARD.md","HANDOFF_PROMPT.md","REASONING_CONTRACT.md","DEVILS_ADVOCATE.md","AUDIENCE_ANTICIPATION.md","TOOLS_REGISTRY.md") | ForEach-Object { Download-File $_ $_ | Out-Null }

$configFiles = @("HARD_STOPS.md","LESSONS_LEARNED.md","NON_GOALS.md","PROJECT_STATE.json","PROJECT_META.json","CAPABILITIES.json")
if ($UpdateMode -eq "fresh") { Write-Host "Downloading configuration files..."; $configFiles | ForEach-Object { Download-File $_ $_ | Out-Null } }
else { Write-Host "Preserving existing configuration files..."; $configFiles | ForEach-Object { Download-IfMissing $_ $_ } }

Write-Host "Downloading templates..."
@("agent.md","reasoning-handoff.md","session.md","handoff.md","error.md","canonical-fact.md","archive-summary.md") | ForEach-Object { Download-File ".templates/$_" ".templates\$_" | Out-Null }

Write-Host "Downloading tool system files..."
@("search.md","storage.md","data.md","communication.md","execution.md") | ForEach-Object { Download-File ".tools/adapters/$_" ".tools\adapters\$_" | Out-Null }
Download-File ".tools/templates/tool-config.md" ".tools\templates\tool-config.md" | Out-Null

Write-Host "Downloading takeover module..."
Download-File ".takeover/TAKEOVER_ORCHESTRATOR.md" ".takeover\TAKEOVER_ORCHESTRATOR.md" | Out-Null
Download-File ".takeover/discovery.json" ".takeover\discovery.json" | Out-Null
Download-File ".takeover/scope-config.json" ".takeover\scope-config.json" | Out-Null
@("structure-auditor.md","documentation-auditor.md","code-quality-auditor.md","security-auditor.md","test-auditor.md") | ForEach-Object { Download-File ".takeover/agent-templates/$_" ".takeover\agent-templates\$_" | Out-Null }

Write-Host "Downloading default rules..."
@("code-standards.md","content-guidelines.md","data-validation.md") | ForEach-Object { Download-File ".rules/$_" ".rules\$_" | Out-Null }

Write-Host "Downloading documentation..."
Download-File ".memory/README.md" ".memory\README.md" | Out-Null
Download-File ".project-catalog/README.md" ".project-catalog\README.md" | Out-Null
Download-File ".project-catalog/sessions/README.md" ".project-catalog\sessions\README.md" | Out-Null

if ($UpdateMode -eq "fresh") { Download-File ".inputs/manifest.json" ".inputs\manifest.json" | Out-Null } else { Download-IfMissing ".inputs/manifest.json" ".inputs\manifest.json" }

Write-Host "Ensuring directory placeholders..."
@(".agents\_archive",".checkpoints",".memory\canonical",".memory\working",".memory\disposable",".outputs\_drafts",".project-catalog\sessions",".project-catalog\decisions",".project-catalog\agents",".project-catalog\errors",".project-catalog\handoffs",".project-catalog\archive",".tools\installed",".takeover\audits",".takeover\evidence") | ForEach-Object { $gk = "$_\.gitkeep"; if (-not (Test-Path $gk)) { "# Preserves directory" | Out-File -FilePath $gk -Encoding UTF8 } }

$VERSION | Out-File -FilePath ".udo-version" -Encoding UTF8 -NoNewline
if (Test-Path "PROJECT_META.json") { try { $m = Get-Content "PROJECT_META.json" -Raw | ConvertFrom-Json; $m.udo_version = $VERSION; $m | ConvertTo-Json -Depth 10 | Set-Content "PROJECT_META.json" -Encoding UTF8 } catch { } }

Pop-Location

Write-Host ""
if ($UpdateMode -eq "fresh") { Write-Host "✓ UDO v$VERSION installed successfully!" -ForegroundColor Green }
else { Write-Host "✓ UDO updated to v$VERSION!" -ForegroundColor Green; Write-Host "  Your project data and configuration were preserved." -ForegroundColor Blue }

Write-Host ""; Write-Host "Next steps:"; Write-Host "1. Configure your AI with this system prompt addition:"; Write-Host ""
Write-Host "   Before responding to any request, read the project's" -ForegroundColor Yellow
Write-Host "   UDO/START_HERE.md and follow its instructions." -ForegroundColor Yellow
Write-Host ""; Write-Host '2. Tell your AI: "Read UDO/START_HERE.md and begin"'
