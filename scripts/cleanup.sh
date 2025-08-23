#!/bin/bash

# Mac Cleanup Script
# This script safely cleans up various caches, logs, and temporary files
# Run with: chmod +x cleanup.sh && ./cleanup.sh

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to get directory size
get_size() {
    if [ -d "$1" ]; then
        du -sh "$1" 2>/dev/null | cut -f1
    else
        echo "0B"
    fi
}

# Function to safely remove directory contents
safe_cleanup() {
    local dir="$1"
    local desc="$2"
    
    if [ -d "$dir" ]; then
        local size=$(get_size "$dir")
        print_status "Cleaning $desc ($size)..."
        
        # Only remove contents, not the directory itself
        find "$dir" -mindepth 1 -delete 2>/dev/null || true
        print_success "Cleaned $desc"
    else
        print_warning "$desc directory not found: $dir"
    fi
}

# Function to clean up files matching pattern
clean_pattern() {
    local pattern="$1"
    local desc="$2"
    local count
    
    count=$(find . -name "$pattern" -type f 2>/dev/null | wc -l | tr -d ' ')
    if [ "$count" -gt 0 ]; then
        print_status "Removing $count $desc files..."
        find . -name "$pattern" -type f -delete 2>/dev/null || true
        print_success "Removed $desc files"
    fi
}

echo "🧹 Mac Cleanup Script"
echo "===================="
echo

# Check if running as root (not recommended)
if [ "$EUID" -eq 0 ]; then
    print_error "Please don't run this script as root/sudo"
    exit 1
fi

print_status "Starting cleanup process..."
echo

# 1. System Caches
# print_status "Cleaning system caches..."
# safe_cleanup "$HOME/Library/Caches" "user caches"
# safe_cleanup "/tmp" "temporary files"

# 2. Browser Caches (be careful with user data)
# print_status "Cleaning browser caches..."
# safe_cleanup "$HOME/Library/Caches/Google/Chrome" "Chrome cache"
# safe_cleanup "$HOME/Library/Application Support/Google/Chrome/Default/Application Cache" "Chrome app cache"

# 3. Development-related cleanup
print_status "Cleaning development caches..."

# Node.js and npm
safe_cleanup "$HOME/.npm/_cacache" "npm cache"
if command -v npm &> /dev/null; then
    print_status "Cleaning npm cache..."
    npm cache clean --force 2>/dev/null || true
fi

# Yarn cache
if command -v yarn &> /dev/null; then
    print_status "Cleaning Yarn cache..."
    yarn cache clean 2>/dev/null || true
fi

# pnpm cache (you have this installed)
if command -v pnpm &> /dev/null; then
    print_status "Cleaning pnpm cache..."
    pnpm store prune 2>/dev/null || true
fi

# Bun cache (you have this installed) 
if command -v bun &> /dev/null; then
    print_status "Cleaning Bun cache..."
    rm -rf "$HOME/.bun/install/cache" 2>/dev/null || true
fi

# Go module cache
safe_cleanup "$HOME/go/pkg/mod/cache" "Go module cache"

# Rust cargo cache
safe_cleanup "$HOME/.cargo/registry/cache" "Rust cargo cache"

# 4. Docker cleanup (you have Docker installed)
if command -v docker &> /dev/null && docker info &> /dev/null; then
    print_status "Cleaning Docker..."
    docker system prune -f 2>/dev/null || true
    docker image prune -f 2>/dev/null || true
    print_success "Docker cleanup completed"
fi

# 5. Podman cleanup (you have Podman installed)
if command -v podman &> /dev/null; then
    print_status "Cleaning Podman..."
    podman system prune -f 2>/dev/null || true
    podman image prune -f 2>/dev/null || true
    print_success "Podman cleanup completed"
fi

# 6. Homebrew cleanup (you're clearly using Homebrew extensively)
if command -v brew &> /dev/null; then
    print_status "Cleaning Homebrew..."
    brew cleanup --prune=all 2>/dev/null || true
    brew autoremove 2>/dev/null || true
    print_success "Homebrew cleanup completed"
fi

# 7. System logs (older than 7 days)
print_status "Cleaning old system logs..."
sudo log collect --last 7d --output /dev/null 2>/dev/null || true

# 8. Xcode derived data (if Xcode is installed)
if [ -d "$HOME/Library/Developer/Xcode/DerivedData" ]; then
    safe_cleanup "$HOME/Library/Developer/Xcode/DerivedData" "Xcode derived data"
fi

# 9. Clean up common temporary file patterns in current directory and subdirectories
# print_status "Cleaning temporary files in current directory..."
# clean_pattern "*.tmp" "temporary"
# clean_pattern "*.temp" "temporary"
# clean_pattern ".DS_Store" "DS_Store"
# clean_pattern "Thumbs.db" "Windows thumbnail"
# clean_pattern "*.log" "log"
# clean_pattern "*.swp" "Vim swap"
# clean_pattern "*.swo" "Vim swap"
# clean_pattern "*~" "backup"

# 10. Node.js node_modules cleanup (be careful - only clean if package.json exists)
if [ -f "package.json" ]; then
    print_status "Found package.json - looking for node_modules to clean..."
    find . -name "node_modules" -type d -prune | while read -r dir; do
        size=$(get_size "$dir")
        print_status "Removing node_modules at $dir ($size)..."
        rm -rf "$dir"
    done
    print_success "Node modules cleanup completed"
fi

# 11. Empty trash
print_status "Emptying trash..."
osascript -e 'tell application "Finder" to empty trash' 2>/dev/null || true
print_success "Trash emptied"

# 12. Clear font caches (since you work with fonts based on your Brewfile)
# print_status "Clearing font caches..."
# sudo atsutil databases -remove 2>/dev/null || true

# 13. Repair disk permissions
# print_status "Repairing disk permissions..."
# sudo diskutil repairPermissions / 2>/dev/null || true

echo
print_success "🎉 Cleanup completed!"

# Show some system stats
echo
print_status "System Information:"
echo "📊 Disk Usage:"
df -h / | tail -1 | awk '{print "   Available: " $4 " (" $5 " used)"}'

echo "💾 Memory Usage:"
vm_stat | head -5

echo
print_status "💡 Additional recommendations:"
echo "   • Restart your Mac to clear memory caches"
echo "   • Run 'brew doctor' to check Homebrew health"
echo "   • Consider using 'ncdu' to find large directories"
echo "   • Check Activity Monitor for memory-hungry apps"

echo
print_success "All done! 🚀"
