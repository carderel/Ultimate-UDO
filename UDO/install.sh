#!/bin/bash
# UDO v4.5 Installer
# Universal Dynamic Orchestrator - Hybrid Installation

set -e

VERSION="4.5"
REPO_URL="https://raw.githubusercontent.com/carderel/Ultimate-UDO/main/UDO"
UDO_DIR="UDO"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Parse command line arguments
UPDATE_MODE=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --update|-u)
            UPDATE_MODE="update"
            shift
            ;;
        --fresh|-f)
            UPDATE_MODE="fresh"
            shift
            ;;
        --overwrite|-o)
            UPDATE_MODE="overwrite"
            shift
            ;;
        --help|-h)
            echo "UDO v${VERSION} Installer"
            echo ""
            echo "Usage: install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --update, -u     Update core files only (preserves project data)"
            echo "  --fresh, -f      Fresh install (removes existing UDO data)"
            echo "  --overwrite, -o  Same as --fresh"
            echo "  --help, -h       Show this help message"
            echo ""
            echo "Examples:"
            echo "  Fresh install:   curl -fsSL URL/install.sh | bash"
            echo "  Update:          curl -fsSL URL/install.sh | bash -s -- --update"
            echo "  Fresh reinstall: curl -fsSL URL/install.sh | bash -s -- --fresh"
            exit 0
            ;;
        *)
            shift
            ;;
    esac
done

echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║         UDO - Universal Dynamic Orchestrator v${VERSION}         ║"
echo "║              AI Project Management System                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Function to get installed version
get_installed_version() {
    if [ -f "$UDO_DIR/.udo-version" ]; then
        cat "$UDO_DIR/.udo-version" 2>/dev/null || echo "unknown"
    elif [ -f "$UDO_DIR/PROJECT_META.json" ]; then
        grep -o '"udo_version"[[:space:]]*:[[:space:]]*"[^"]*"' "$UDO_DIR/PROJECT_META.json" 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+' || echo "unknown"
    else
        echo "unknown"
    fi
}

# Check if UDO is already installed
if [ -f "$UDO_DIR/ORCHESTRATOR.md" ] || [ -f "$UDO_DIR/START_HERE.md" ]; then
    INSTALLED_VERSION=$(get_installed_version)
    
    echo -e "${YELLOW}UDO is already installed in this directory.${NC}"
    echo ""
    echo -e "  Installed version: ${BLUE}${INSTALLED_VERSION}${NC}"
    echo -e "  Latest version:    ${BLUE}${VERSION}${NC}"
    echo ""
    
    # Check if update available
    if [ "$INSTALLED_VERSION" != "$VERSION" ]; then
        echo -e "${GREEN}Update available!${NC}"
        echo ""
    fi
    
    # If no mode specified via command line, show menu
    if [ -z "$UPDATE_MODE" ]; then
        echo "What would you like to do?"
        echo ""
        echo "  1) Update - Refresh system files, keep your data"
        echo "  2) Fresh install - Start over (removes UDO project data)"
        echo "  3) Skip this time"
        echo ""
        echo -e "${YELLOW}Since this is running via pipe, select an option:${NC}"
        echo ""
        echo "  To update (recommended):"
        echo "    curl -fsSL $REPO_URL/install.sh | bash -s -- --update"
        echo ""
        echo "  To fresh install:"
        echo "    curl -fsSL $REPO_URL/install.sh | bash -s -- --fresh"
        echo ""
        echo "  To skip: just don't run the command again"
        echo ""
        exit 0
    fi
    
    # Handle fresh install - remove existing UDO folder
    if [ "$UPDATE_MODE" = "fresh" ] || [ "$UPDATE_MODE" = "overwrite" ]; then
        echo -e "${RED}Removing existing UDO installation...${NC}"
        rm -rf "$UDO_DIR"
        UPDATE_MODE="fresh"
    fi
else
    # No existing installation
    if [ -z "$UPDATE_MODE" ]; then
        UPDATE_MODE="fresh"
    fi
fi

echo ""
echo "Installing UDO v${VERSION} to: $(pwd)/$UDO_DIR"
echo -e "Mode: ${BLUE}${UPDATE_MODE}${NC}"
echo ""

# Create UDO directory
mkdir -p "$UDO_DIR"
cd "$UDO_DIR"

# Create directory structure
echo "Creating directory structure..."
mkdir -p .agents/_archive
mkdir -p .checkpoints
mkdir -p .inputs
mkdir -p .memory/canonical .memory/working .memory/disposable
mkdir -p .outputs/_drafts
mkdir -p .project-catalog/sessions .project-catalog/decisions .project-catalog/agents
mkdir -p .project-catalog/errors .project-catalog/handoffs .project-catalog/archive
mkdir -p .rules
mkdir -p .templates
mkdir -p .tools/adapters .tools/installed .tools/templates
mkdir -p .takeover/agent-templates .takeover/audits .takeover/evidence

# Download function
download_file() {
    local file=$1
    local url="${REPO_URL}/template/${file}"
    if command -v curl &> /dev/null; then
        curl -fsSL "$url" -o "$file" 2>/dev/null || echo -e "${YELLOW}Warning: Could not download $file${NC}"
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$file" 2>/dev/null || echo -e "${YELLOW}Warning: Could not download $file${NC}"
    fi
}

# Download only if missing (for config files during update)
download_if_missing() {
    local file=$1
    if [ ! -f "$file" ]; then
        download_file "$file"
    else
        echo -e "  ${BLUE}Kept existing:${NC} $file"
    fi
}

# Core system files (always updated)
CORE_FILES="START_HERE.md ORCHESTRATOR.md COMMANDS.md OVERSIGHT_DASHBOARD.md HANDOFF_PROMPT.md REASONING_CONTRACT.md DEVILS_ADVOCATE.md AUDIENCE_ANTICIPATION.md TOOLS_REGISTRY.md"

# Config files (only on fresh install)
CONFIG_FILES="HARD_STOPS.md LESSONS_LEARNED.md NON_GOALS.md PROJECT_STATE.json PROJECT_META.json CAPABILITIES.json"

# Download core files
echo "Downloading core files..."
for file in $CORE_FILES; do
    download_file "$file"
done

# Download config files based on mode
if [ "$UPDATE_MODE" = "fresh" ]; then
    echo "Downloading configuration files..."
    for file in $CONFIG_FILES; do
        download_file "$file"
    done
else
    echo "Preserving existing configuration files..."
    for file in $CONFIG_FILES; do
        download_if_missing "$file"
    done
fi

# Template files (always update)
echo "Downloading templates..."
download_file ".templates/agent.md"
download_file ".templates/reasoning-handoff.md"
download_file ".templates/session.md"
download_file ".templates/handoff.md"
download_file ".templates/error.md"
download_file ".templates/canonical-fact.md"
download_file ".templates/archive-summary.md"

# Tool system files (always update)
echo "Downloading tool system files..."
download_file ".tools/adapters/search.md"
download_file ".tools/adapters/storage.md"
download_file ".tools/adapters/data.md"
download_file ".tools/adapters/communication.md"
download_file ".tools/adapters/execution.md"
download_file ".tools/templates/tool-config.md"

# Takeover module files (always update)
echo "Downloading takeover module..."
download_file ".takeover/TAKEOVER_ORCHESTRATOR.md"
download_file ".takeover/discovery.json"
download_file ".takeover/scope-config.json"
download_file ".takeover/agent-templates/structure-auditor.md"
download_file ".takeover/agent-templates/documentation-auditor.md"
download_file ".takeover/agent-templates/code-quality-auditor.md"
download_file ".takeover/agent-templates/security-auditor.md"
download_file ".takeover/agent-templates/test-auditor.md"

# Default rules (always update)
echo "Downloading default rules..."
download_file ".rules/code-standards.md"
download_file ".rules/content-guidelines.md"
download_file ".rules/data-validation.md"

# README files (always update)
echo "Downloading documentation..."
download_file ".memory/README.md"
download_file ".project-catalog/README.md"
download_file ".project-catalog/sessions/README.md"

# Manifest only on fresh
if [ "$UPDATE_MODE" = "fresh" ]; then
    download_file ".inputs/manifest.json"
else
    download_if_missing ".inputs/manifest.json"
fi

# Create .gitkeep files
echo "Ensuring directory placeholders..."
for dir in .agents/_archive .checkpoints .memory/canonical .memory/working .memory/disposable .outputs/_drafts .project-catalog/sessions .project-catalog/decisions .project-catalog/agents .project-catalog/errors .project-catalog/handoffs .project-catalog/archive .tools/installed .takeover/audits .takeover/evidence; do
    if [ ! -f "$dir/.gitkeep" ]; then
        echo "# This file preserves the directory in git" > "$dir/.gitkeep"
    fi
done

# Save version file
echo "$VERSION" > .udo-version

# Update version in PROJECT_META.json if it exists
if [ -f "PROJECT_META.json" ]; then
    if command -v sed &> /dev/null; then
        sed -i.bak 's/"udo_version"[[:space:]]*:[[:space:]]*"[^"]*"/"udo_version": "'"$VERSION"'"/' PROJECT_META.json 2>/dev/null && rm -f PROJECT_META.json.bak
    fi
fi

# Return to original directory
cd ..

echo ""
if [ "$UPDATE_MODE" = "fresh" ]; then
    echo -e "${GREEN}✓ UDO v${VERSION} installed successfully!${NC}"
else
    echo -e "${GREEN}✓ UDO updated to v${VERSION}!${NC}"
    echo -e "${BLUE}  Your project data and configuration were preserved.${NC}"
fi

echo ""
echo "Next steps:"
echo "1. Configure your AI with this system prompt addition:"
echo ""
echo -e "${YELLOW}   Before responding to any request, read the project's"
echo -e "   UDO/START_HERE.md and follow its instructions.${NC}"
echo ""
echo "2. Tell your AI: \"Read UDO/START_HERE.md and begin\""
