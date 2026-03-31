#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Shanaajensine | Course: Open Source Software
# Description: Loops through key system directories and reports
#              their size, owner, and permissions using a for loop

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")

echo "================================================"
echo "   Directory Audit Report"
echo "================================================"
echo ""

# --- Loop through each directory using a for loop ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        echo "  Directory : $DIR"
        echo "  Size      : $SIZE"
        echo "  Owner     : $OWNER / Group: $GROUP"
        echo "  Permission: $PERMS"
        echo "  ----------------------------------------"
    else
        echo "  $DIR does not exist on this system"
        echo "  ----------------------------------------"
    fi
done

echo ""
echo "================================================"
echo "   Git Configuration Directory Check"
echo "================================================"
echo ""

GIT_CONFIG_DIR="/etc/gitconfig"
GIT_CORE_DIR="/usr/lib/git-core"

if [ -f "$GIT_CONFIG_DIR" ]; then
    echo "  Git global config found at: $GIT_CONFIG_DIR"
    ls -la "$GIT_CONFIG_DIR"
else
    echo "  No global gitconfig file found at $GIT_CONFIG_DIR"
    echo "  (This is normal if no system-wide config has been set)"
fi

echo ""

if [ -d "$GIT_CORE_DIR" ]; then
    PERMS=$(ls -ld "$GIT_CORE_DIR" | awk '{print $1}')
    OWNER=$(ls -ld "$GIT_CORE_DIR" | awk '{print $3}')
    echo "  Git core directory : $GIT_CORE_DIR"
    echo "  Permissions        : $PERMS"
    echo "  Owner              : $OWNER"
else
    echo "  Git core directory not found at $GIT_CORE_DIR"
fi

echo ""
echo "================================================"
