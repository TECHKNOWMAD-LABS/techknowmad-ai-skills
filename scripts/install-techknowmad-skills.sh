#!/usr/bin/env bash
# =======================================================================
# TechKnowmad AI -- Skills Installation Script
# Installs all 20 TechKnowmad custom + combination skills
# + clones 16 community skill repos and links best skills
# =======================================================================
set -euo pipefail

# === FLAGS ===
DRY_RUN=false
SKIP_COMMUNITY=false
for arg in "$@"; do
    case "$arg" in
        --dry-run)    DRY_RUN=true ;;
        --no-community) SKIP_COMMUNITY=true ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --dry-run        Show what would be installed without making changes"
            echo "  --no-community   Skip cloning community skill repos (install only TechKnowmad skills)"
            echo "  --help, -h       Show this help message"
            exit 0
            ;;
        *) echo "Unknown option: $arg. Use --help for usage."; exit 1 ;;
    esac
done

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

SKILLS_DIR="${HOME}/.claude/skills"
CLONE_DIR="${HOME}/techknowmad-ai/skill-repos"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SUCCESS=0
SKIP=0
FAIL=0

log()  { echo -e "${GREEN}  +${NC} $1"; ((SUCCESS++)); }
warn() { echo -e "${YELLOW}  !${NC} $1"; ((SKIP++)); }
fail() { echo -e "${RED}  x${NC} $1"; ((FAIL++)); }

# === PHASE 1: Prerequisites ===
echo -e "\n${CYAN}=== PHASE 1: PREREQUISITES ===${NC}"
mkdir -p "$SKILLS_DIR" "$CLONE_DIR"

if ! command -v git &>/dev/null; then
    fail "Git is required but not installed."
    echo -e "  ${YELLOW}Install git manually:${NC}"
    echo "    macOS:  xcode-select --install"
    echo "    Ubuntu: sudo apt-get install -y git"
    echo "    Fedora: sudo dnf install -y git"
    echo "    Arch:   sudo pacman -S git"
    echo ""
    echo "  Then re-run this script."
    exit 1
fi

if ! command -v claude &>/dev/null; then
    fail "Claude Code CLI not found. Install it first: npm install -g @anthropic-ai/claude-code"
    echo "  Skills will still be installed to $SKILLS_DIR but won't be auto-detected until Claude Code is available."
fi

log "Prerequisites verified"

# === PHASE 2: Install TechKnowmad Custom Skills (10) ===
echo -e "\n${CYAN}=== PHASE 2: INSTALLING TECHKNOWMAD CUSTOM SKILLS ===${NC}"

install_skill() {
    local src="$1"
    local name="$2"
    if [ -d "$src" ] && [ -f "$src/SKILL.md" ]; then
        if $DRY_RUN; then
            log "[DRY RUN] Would link $name -> $src"
        else
            ln -sfn "$src" "$SKILLS_DIR/$name" && log "$name" || fail "$name link failed"
        fi
    else
        fail "$name: source not found at $src"
    fi
}

CUSTOM_SKILLS=(
    "research-commander"
    "swarm-commander"
    "model-evaluator"
    "agent-debugger"
    "self-healing-agent"
    "prompt-evolution"
    "skill-factory"
    "patent-researcher"
    "cost-optimizer"
    "knowledge-distiller"
)

for skill in "${CUSTOM_SKILLS[@]}"; do
    install_skill "$SCRIPT_DIR/custom-skills/$skill" "tkm-$skill"
done

# === PHASE 3: Install TechKnowmad Combination Skills (10) ===
echo -e "\n${CYAN}=== PHASE 3: INSTALLING TECHKNOWMAD COMBINATION SKILLS ===${NC}"

COMBO_SKILLS=(
    "multi-agent-research-swarm"
    "red-team-ai-models"
    "self-evolving-skill-ecosystem"
    "academic-output-pipeline"
    "antifragile-ai-ops"
    "pareto-prompt-optimizer"
    "zero-touch-ml-pipeline"
    "startup-creative-automation"
    "compliance-as-code"
    "ip-aware-competitive-intel"
)

for skill in "${COMBO_SKILLS[@]}"; do
    install_skill "$SCRIPT_DIR/combination-skills/$skill" "tkm-$skill"
done

# === PHASE 4: Clone Community Skill Repos ===
if $SKIP_COMMUNITY; then
    echo -e "\n${YELLOW}=== PHASE 4: SKIPPED (--no-community) ===${NC}"
else
echo -e "\n${CYAN}=== PHASE 4: CLONING COMMUNITY SKILL REPOSITORIES ===${NC}"

clone_repo() {
    local url="$1"
    local dir="$2"
    # Validate URL is HTTPS GitHub
    if [[ ! "$url" =~ ^https://github\.com/ ]]; then
        fail "$dir: refusing to clone non-GitHub HTTPS URL: $url"
        return
    fi
    if $DRY_RUN; then
        log "[DRY RUN] Would clone $url -> $CLONE_DIR/$dir"
        return
    fi
    if [ -d "$CLONE_DIR/$dir" ]; then
        warn "$dir already cloned (updating...)"
        cd "$CLONE_DIR/$dir" && git pull --ff-only 2>/dev/null && cd - >/dev/null || true
    else
        git clone --depth 1 "$url" "$CLONE_DIR/$dir" 2>/dev/null && log "Cloned $dir" || fail "Failed to clone $dir"
    fi
}

# Mega Collections
clone_repo "https://github.com/anthropics/skills.git" "anthropic-official"
clone_repo "https://github.com/alirezarezvani/claude-skills.git" "claude-skills-180"
clone_repo "https://github.com/VoltAgent/awesome-agent-skills.git" "voltagent-skills"

# AI/ML Research
clone_repo "https://github.com/Orchestra-Research/AI-Research-SKILLs.git" "ai-research"
clone_repo "https://github.com/K-Dense-AI/claude-scientific-skills.git" "scientific-skills"
clone_repo "https://github.com/K-Dense-AI/claude-scientific-writer.git" "scientific-writer"

# Security
clone_repo "https://github.com/transilienceai/communitytools.git" "security-tools"
clone_repo "https://github.com/trailofbits/skills.git" "trailofbits"
clone_repo "https://github.com/blacklanternsecurity/red-run.git" "red-run"

# DevOps/SRE
clone_repo "https://github.com/ahmedasmar/devops-claude-skills.git" "devops-skills"
clone_repo "https://github.com/VoltAgent/awesome-claude-code-subagents.git" "subagents"

# Skill Factory & Templates
clone_repo "https://github.com/alirezarezvani/claude-code-skill-factory.git" "skill-factory-repo"

# n8n Automation
clone_repo "https://github.com/czlonkowski/n8n-skills.git" "n8n-skills"

# Production Delivery
clone_repo "https://github.com/levnikolaevich/claude-code-skills.git" "delivery-skills"
clone_repo "https://github.com/bobmatnyc/claude-mpm-skills.git" "mpm-skills"

# === PHASE 5: Link Community Skills ===
echo -e "\n${CYAN}=== PHASE 5: LINKING COMMUNITY SKILLS ===${NC}"

link_dir_skills() {
    local base_dir="$1"
    local prefix="$2"
    local search_depth="${3:-2}"

    if [ ! -d "$base_dir" ]; then
        warn "Directory not found: $base_dir"
        return
    fi

    # Find directories containing SKILL.md
    while IFS= read -r skill_md; do
        local skill_dir
        skill_dir="$(dirname "$skill_md")"
        local skill_name
        skill_name="$(basename "$skill_dir")"
        # Skip if already linked with same or different prefix
        if [ ! -L "$SKILLS_DIR/${prefix}${skill_name}" ]; then
            if $DRY_RUN; then
                log "[DRY RUN] Would link ${prefix}${skill_name}"
            else
                ln -sfn "$skill_dir" "$SKILLS_DIR/${prefix}${skill_name}" 2>/dev/null && log "${prefix}${skill_name}" || warn "${prefix}${skill_name} link failed"
            fi
        else
            warn "${prefix}${skill_name} already linked"
        fi
    done < <(find "$base_dir" -maxdepth "$search_depth" -name "SKILL.md" -type f 2>/dev/null)
}

echo "Linking Anthropic official skills..."
link_dir_skills "$CLONE_DIR/anthropic-official" "anthro-" 3

echo "Linking AI Research skills..."
link_dir_skills "$CLONE_DIR/ai-research" "research-" 3

echo "Linking Scientific skills..."
link_dir_skills "$CLONE_DIR/scientific-skills" "sci-" 3
link_dir_skills "$CLONE_DIR/scientific-writer" "sciwrite-" 3

echo "Linking Security skills..."
link_dir_skills "$CLONE_DIR/security-tools" "sec-" 4
link_dir_skills "$CLONE_DIR/trailofbits" "tob-" 3
link_dir_skills "$CLONE_DIR/red-run" "redrun-" 3

echo "Linking DevOps skills..."
link_dir_skills "$CLONE_DIR/devops-skills" "devops-" 3

echo "Linking community skills..."
link_dir_skills "$CLONE_DIR/claude-skills-180" "comm-" 3
link_dir_skills "$CLONE_DIR/voltagent-skills" "volt-" 3
link_dir_skills "$CLONE_DIR/subagents" "sub-" 3

echo "Linking n8n skills..."
link_dir_skills "$CLONE_DIR/n8n-skills" "n8n-" 3

echo "Linking delivery skills..."
link_dir_skills "$CLONE_DIR/delivery-skills" "dlvr-" 3
link_dir_skills "$CLONE_DIR/mpm-skills" "mpm-" 3

fi  # end SKIP_COMMUNITY guard

# === SUMMARY ===
echo ""
echo -e "${CYAN}===================================================${NC}"
echo -e "${CYAN}  TECHKNOWMAD AI SKILLS INSTALLATION COMPLETE${NC}"
echo -e "${CYAN}===================================================${NC}"
echo ""
echo -e "  ${GREEN}Succeeded:${NC} $SUCCESS"
echo -e "  ${YELLOW}Skipped:${NC}   $SKIP"
echo -e "  ${RED}Failed:${NC}    $FAIL"
echo ""
echo -e "  Skills directory: ${CYAN}$SKILLS_DIR${NC}"
echo -e "  Cloned repos:    ${CYAN}$CLONE_DIR${NC}"
echo ""

TOTAL_SKILLS=$(find "$SKILLS_DIR" -maxdepth 1 -type l 2>/dev/null | wc -l | tr -d ' ')
echo -e "  Total skills linked: ${GREEN}$TOTAL_SKILLS${NC}"
echo ""
echo -e "  ${YELLOW}ACTION REQUIRED:${NC} Restart Claude Code to load all skills."
echo ""
echo -e "  Verify with: ${CYAN}ls -la ~/.claude/skills/ | head -30${NC}"
echo ""
echo "  +-------------------------------------------------+"
echo "  |  TechKnowmad AI -- Ultra Mega Skill Ecosystem    |"
echo "  |  20 custom skills + community repos linked       |"
echo "  |  techknowmad.ai                                  |"
echo "  +-------------------------------------------------+"
echo ""
