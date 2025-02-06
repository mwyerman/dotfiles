#!/bin/sh

# Fetch the latest remote information
git fetch

# Initialize an empty error message
ERRORS=""

# Check for uncommitted changes
# if ! git diff-index --quiet HEAD --; then
if [ -n "$(git status --porcelain=v1 2>/dev/null | grep -v '^??')" ]; then
    ERRORS="$ERRORS❌ Uncommitted changes found. Run \`git status\` to review.\n"
fi

# Check for unpushed commits and display branch names
UNPUSHED_BRANCHES=$(git branch --format "%(refname:short)" | while read -r branch; do
    UNPUSHED_COMMITS=$(git log origin/"$branch"..$branch --oneline 2>/dev/null)
    if [ -n "$UNPUSHED_COMMITS" ]; then
        echo "🔹 Branch: $branch"
        echo "$UNPUSHED_COMMITS" | sed 's/^/    /'
    fi
done)

if [ -n "$UNPUSHED_BRANCHES" ]; then
    ERRORS="$ERRORS❌ Unpushed commits found:\n$UNPUSHED_BRANCHES\n"
fi

# Check if branch is behind the remote
if git status | grep -q 'Your branch is behind'; then
    ERRORS="$ERRORS❌ Unpulled changes found. Run \`git pull\` to sync.\n"
fi

# Get all local branches
LOCAL_BRANCHES=$(git branch --format "%(refname:short)")

# Get all remote branches (removing 'origin/' prefix)
REMOTE_BRANCHES=$(git branch -r | sed 's|origin/||' | sort | uniq)

# Detect local branches that don't exist on the remote
LOCAL_ONLY=""
for BRANCH in $LOCAL_BRANCHES; do
    # Skip if the branch has an upstream
    if git rev-parse --abbrev-ref --symbolic-full-name "$BRANCH@{u}" >/dev/null 2>&1; then
        continue
    fi

    # Check if the branch is merged into main (or default branch)
    if git branch --merged main | grep -q " $BRANCH\$"; then
        LOCAL_ONLY="$LOCAL_ONLY    󰄬 $BRANCH (Merged, safe to delete, or 'git branch -d $BRANCH')\n"
    else
        LOCAL_ONLY="$LOCAL_ONLY    󰅖 $BRANCH (Not merged! May contain work, use 'git branch -D $BRANCH' with caution)\n"
    fi
done

if [ -n "$LOCAL_ONLY" ]; then
    ERRORS="$ERRORS󰅖 Local branches with no remote counterpart:\n$LOCAL_ONLY    Tip: Run 'git fetch --prune' to update remote branch list.\n"
fi

# Print results
if [ -z "$ERRORS" ]; then
    echo "✅ Repository is fully synced! Safe to delete."
    exit 0
else
    printf "$ERRORS"
    exit 1
fi

