---
name: create-symbolic-links-for-prompts
description: Create symbolic links for all prompt files from the dotfiles prompts directory to the VS Code Insiders User prompts folder
argument-hint: Optional confirmation to proceed with creating symbolic links
---

# Create Symbolic Links for Prompts

This command creates symbolic links for all `.prompt.md` files in the dotfiles prompts folder to the VS Code Insiders User prompts directory.

## Target Directories:
- **Source**: `~/.dotfiles/prompts/`
- **Target**: `~/Library/Application Support/Code - Insiders/User/prompts`

## Steps:
1. Run a dry-run to show what will be created
2. Display the preview to the user for confirmation
3. Wait for user confirmation
4. Check if the target directory exists; create it if necessary
5. List all `.prompt.md` files in the source directory
6. For each prompt file, create a symbolic link in the target directory
7. Skip any files that already have links (avoid duplicates)
8. Verify all links were created successfully

## Dry-Run Command (Preview):
```bash
TARGET_DIR="$HOME/Library/Application Support/Code - Insiders/User/prompts"
SOURCE_DIR="$HOME/.dotfiles/prompts"

echo "=== DRY RUN: Symbolic Links to be created ==="
echo ""
echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"
echo ""
echo "Prompt files to link:"
for file in "$SOURCE_DIR"/*.prompt.md; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    target_link="$TARGET_DIR/$filename"
    
    if [ -L "$target_link" ]; then
      echo "  ✓ $filename (already linked)"
    else
      echo "  → $filename (will be created)"
    fi
  fi
done
echo ""
echo "=== End of Dry Run ==="
```

## Real Execution Command:
```bash
TARGET_DIR="$HOME/Library/Application Support/Code - Insiders/User/prompts"
SOURCE_DIR="$HOME/.dotfiles/prompts"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Create symbolic links for all .prompt.md files
for file in "$SOURCE_DIR"/*.prompt.md; do
  filename=$(basename "$file")
  target_link="$TARGET_DIR/$filename"
  
  # Only create if link doesn't already exist
  if [ ! -L "$target_link" ]; then
    ln -s "$file" "$target_link"
    echo "Created link: $filename"
  else
    echo "Link already exists: $filename"
  fi
done

# Verify
echo "---"
echo "Symbolic links in target directory:"
ls -la "$TARGET_DIR"
```

## Result:
After reviewing the dry-run output and confirming, all prompt files will be accessible to VS Code Insiders through symbolic links, allowing you to keep a single source of truth in your dotfiles.

## Workflow:
1. **Review**: See the dry-run output showing which links will be created and which already exist
2. **Confirm**: User reviews and approves the changes
3. **Execute**: Run the real command to create the symbolic links
4. **Verify**: Confirm all links were created successfully

````
