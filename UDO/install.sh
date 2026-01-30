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
MIGRATE_MODE=""
while [[ \$# -gt 0 ]]; do
    case \$1 in
        --update|-u)
            UPDATE_MODE="update"
            shift
            ;;
        --fresh|-f)
            UPDATE_MODE="fresh"
            shift
            ;;
        --migrate|-m)
            MIGRATE_MODE="yes"
            shift
            ;;
        --help|-h)
            echo "UDO v\${VERSION} Installer"
            echo ""
            echo "Usage: install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --update, -u     Update core files only (preserves project data)"
            echo "  --fresh, -f      Fresh install (removes existing UDO data)"
            echo "  --migrate, -m    Migrate legacy root install to UDO/ subfolder"
            echo "  --help, -h       Show this help message"
            exit 0
            ;;
        *)
            shift
            ;;
    esac
done

echo -e "\${CYAN}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║         UDO - Universal Dynamic Orchestrator v\${VERSION}         ║"
echo "║              AI Project Management System                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "\${NC}"

get_installed_version() {
    if [ -f "\$UDO_DIR/.udo-version" ]; then
        cat "\$UDO_DIR/.udo-version" 2>/dev/null || echo "unknown"
    elif [ -f "\$UDO_DIR/PROJECT_META.json" ]; then
        grep -o '"udo_version"[[:space:]]*:[[:space:]]*"[^"]*"' "\$UDO_DIR/PROJECT_META.json" 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+' || echo "unknown"
    elif [ -f ".udo-version" ]; then
        cat ".udo-version" 2>/dev/null || echo "unknown"
    elif [ -f "PROJECT_META.json" ]; then
        grep -o '"udo_version"[[:space:]]*:[[:space:]]*"[^"]*"' "PROJECT_META.json" 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+' || echo "unknown"
    else
        echo "unknown"
    fi
}

migrate_legacy_install() {
    echo -e "\${YELLOW}Migrating legacy installation to UDO/ subfolder...\${NC}"
    mkdir -p "\$UDO_DIR"
    
    for file in ORCHESTRATOR.md START_HERE.md COMMANDS.md OVERSIGHT_DASHBOARD.md HANDOFF_PROMPT.md REASONING_CONTRACT.md DEVILS_ADVOCATE.md AUDIENCE_ANTICIPATION.md TOOLS_REGISTRY.md HARD_STOPS.md LESSONS_LEARNED.md NON_GOALS.md PROJECT_STATE.json PROJECT_META.json CAPABILITIES.json .udo-version; do
        if [ -f "\$file" ]; then
            mv "\$file" "\$UDO_DIR/" 2>/dev/null && echo -e "  \${GREEN}Moved:\${NC} \$file"
        fi
    done
    
    for dir in .agents .checkpoints .inputs .memory .outputs .project-catalog .rules .templates .tools .takeover; do
        if [ -d "\$dir" ]; then
            mv "\$dir" "\$UDO_DIR/" 2>/dev/null && echo -e "  \${GREEN}Moved:\${NC} \$dir/"
        fi
    done
    
    echo -e "\${GREEN}Migration complete!\${NC}"
    echo ""
}

LEGACY_INSTALL=false
if [ -f "ORCHESTRATOR.md" ] || [ -f "START_HERE.md" ]; then
    if [ ! -d "\$UDO_DIR" ]; then
        LEGACY_INSTALL=true
    fi
fi

if [ "\$LEGACY_INSTALL" = true ]; then
    INSTALLED_VERSION=\$(get_installed_version)
    
    echo -e "\${YELLOW}Legacy UDO installation detected (files at root level).\${NC}"
    echo -e "UDO v4.5+ uses a \${BLUE}UDO/\${NC} subfolder for cleaner organization."
    echo ""
    echo -e "  Installed version: \${BLUE}\${INSTALLED_VERSION}\${NC}"
    echo -e "  Latest version:    \${BLUE}\${VERSION}\${NC}"
    echo ""
    
    if [ "\$MIGRATE_MODE" = "yes" ]; then
        migrate_legacy_install
        UPDATE_MODE="update"
    elif [ -z "\$UPDATE_MODE" ]; then
        echo "What would you like to do?"
        echo ""
        echo "  1) Migrate - Move UDO files into UDO/ subfolder (recommended)"
        echo "  2) Fresh install - Keep old files, create new UDO/ folder"
        echo "  3) Skip this time"
        echo ""
        echo -e "\${YELLOW}Since this is running via pipe, select an option:\${NC}"
        echo ""
        echo "  To migrate (recommended):"
        echo "    curl -fsSL \$REPO_URL/install.sh | bash -s -- --migrate"
        echo ""
        echo "  To fresh install:"
        echo "    curl -fsSL \$REPO_URL/install.sh | bash -s -- --fresh"
        echo ""
        exit 0
    fi
fi

if [ -f "\$UDO_DIR/ORCHESTRATOR.md" ] || [ -f "\$UDO_DIR/START_HERE.md" ]; then
    INSTALLED_VERSION=\$(get_installed_version)
    
    echo -e "\${YELLOW}UDO is already installed in this directory.\${NC}"
    echo ""
    echo -e "  Installed version: \${BLUE}\${INSTALLED_VERSION}\${NC}"
    echo -e "  Latest version:    \${BLUE}\${VERSION}\${NC}"
    echo ""
    
    if [ "\$INSTALLED_VERSION" != "\$VERSION" ]; then
        echo -e "\${GREEN}Update available!\${NC}"
        echo ""
    fi
    
    if [ -z "\$UPDATE_MODE" ]; then
        echo "What would you like to do?"
        echo ""
        echo "  1) Update - Refresh system files, keep your data"
        echo "  2) Fresh install - Start over (removes UDO project data)"
        echo "  3) Skip this time"
        echo ""
        echo -e "\${YELLOW}Since this is running via pipe, select an option:\${NC}"
        echo ""
        echo "  To update (recommended):"
        echo "    curl -fsSL \$REPO_URL/install.sh | bash -s -- --update"
        echo ""
        echo "  To fresh install:"
        echo "    curl -fsSL \$REPO_URL/install.sh | bash -s -- --fresh"
        echo ""
        exit 0
    fi
    
    if [ "\$UPDATE_MODE" = "fresh" ]; then
        echo -e "\${RED}Removing existing UDO installation...\${NC}"
        rm -rf "\$UDO_DIR"
    fi
else
    if [ -z "\$UPDATE_MODE" ]; then
        UPDATE_MODE="fresh"
    fi
fi

echo ""
echo "Installing UDO v\${VERSION} to: \$(pwd)/\$UDO_DIR"
echo -e "Mode: \${BLUE}\${UPDATE_MODE}\${NC}"
echo ""

mkdir -p "\$UDO_DIR"
cd "\$UDO_DIR"

echo "Creating directory structure..."
mkdir -p .agents/_archive .checkpoints .inputs
mkdir -p .memory/canonical .memory/working .memory/disposable
mkdir -p .outputs/_drafts
mkdir -p .project-catalog/sessions .project-catalog/decisions .project-catalog/agents
mkdir -p .project-catalog/errors .project-catalog/handoffs .project-catalog/archive
mkdir -p .rules .templates
mkdir -p .tools/adapters .tools/installed .tools/templates
mkdir -p .takeover/agent-templates .takeover/audits .takeover/evidence

download_file() {
    local file=\$1
    local url="\${REPO_URL}/template/\${file}"
    curl -fsSL "\$url" -o "\$file" 2>/dev/null || echo -e "\${YELLOW}Warning: Could not download \$file\${NC}"
}

download_if_missing() {
    local file=\$1
    if [ ! -f "\$file" ]; then
        download_file "\$file"
    else
        echo -e "  \${BLUE}Kept existing:\${NC} \$file"
    fi
}

CORE_FILES="START_HERE.md ORCHESTRATOR.md COMMANDS.md OVERSIGHT_DASHBOARD.md HANDOFF_PROMPT.md REASONING_CONTRACT.md DEVILS_ADVOCATE.md AUDIENCE_ANTICIPATION.md TOOLS_REGISTRY.md"
CONFIG_FILES="HARD_STOPS.md LESSONS_LEARNED.md NON_GOALS.md PROJECT_STATE.json PROJECT_META.json CAPABILITIES.json"

echo "Downloading core files..."
for file in \$CORE_FILES; do
    download_file "\$file"
done

if [ "\$UPDATE_MODE" = "fresh" ]; then
    echo "Downloading configuration files..."
    for file in \$CONFIG_FILES; do
        download_file "\$file"
    done
else
    echo "Preserving existing configuration files..."
    for file in \$CONFIG_FILES; do
        download_if_missing "\$file"
    done
fi

echo "Downloading templates..."
for t in agent.md reasoning-handoff.md session.md handoff.md error.md canonical-fact.md archive-summary.md; do
    download_file ".templates/\$t"
done

echo "Downloading tool system files..."
for t in search.md storage.md data.md communication.md execution.md; do
    download_file ".tools/adapters/\$t"
done
download_file ".tools/templates/tool-config.md"

echo "Downloading takeover module..."
download_file ".takeover/TAKEOVER_ORCHESTRATOR.md"
download_file ".takeover/discovery.json"
download_file ".takeover/scope-config.json"
for t in structure-auditor.md documentation-auditor.md code-quality-auditor.md security-auditor.md test-auditor.md; do
    download_file ".takeover/agent-templates/\$t"
done

echo "Downloading default rules..."
for t in code-standards.md content-guidelines.md data-validation.md; do
    download_file ".rules/\$t"
done

echo "Downloading documentation..."
download_file ".memory/README.md"
download_file ".project-catalog/README.md"
download_file ".project-catalog/sessions/README.md"

if [ "\$UPDATE_MODE" = "fresh" ]; then
    download_file ".inputs/manifest.json"
else
    download_if_missing ".inputs/manifest.json"
fi

echo "Ensuring directory placeholders..."
for dir in .agents/_archive .checkpoints .memory/canonical .memory/working .memory/disposable .outputs/_drafts .project-catalog/sessions .project-catalog/decisions .project-catalog/agents .project-catalog/errors .project-catalog/handoffs .project-catalog/archive .tools/installed .takeover/audits .takeover/evidence; do
    [ ! -f "\$dir/.gitkeep" ] && echo "# Preserves directory" > "\$dir/.gitkeep"
done

echo "\$VERSION" > .udo-version

cd ..

echo ""
if [ "\$UPDATE_MODE" = "fresh" ]; then
    echo -e "\${GREEN}✓ UDO v\${VERSION} installed successfully!\${NC}"
else
    echo -e "\${GREEN}✓ UDO updated to v\${VERSION}!\${NC}"
    echo -e "\${BLUE}  Your project data and configuration were preserved.\${NC}"
fi

echo ""
echo "Next steps:"
echo "1. Configure your AI with this system prompt addition:"
echo ""
echo -e "\${YELLOW}   Before responding to any request, read the project's"
echo -e "   UDO/START_HERE.md and follow its instructions.\${NC}"
echo ""
echo "2. Tell your AI: \"Read UDO/START_HERE.md and begin\""
