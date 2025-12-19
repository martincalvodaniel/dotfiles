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
SOURCE_DIR="$HOME/.dotfiles/prompts"
TARGET_DIR="$HOME/Library/Application Support/Code - Insiders/User/prompts"

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
ls -alsh $SOURCE_DIR
ls -alsh $TARGET_DIR

# Check for files in TARGET not present in SOURCE
echo "---"
echo "⚠️  Checking for orphaned files in target directory..."
orphaned_count=0
for target_file in "$TARGET_DIR"/*.prompt.md; do
  if [ -e "$target_file" ]; then
    filename=$(basename "$target_file")
    source_file="$SOURCE_DIR/$filename"
    
    if [ ! -f "$source_file" ]; then
      echo "  ⚠️  WARNING: $filename exists in target but NOT in source"
      orphaned_count=$((orphaned_count + 1))
    fi
  fi
done

if [ $orphaned_count -eq 0 ]; then
  echo "  ✓ All target files have corresponding source files"
else
  echo "  ⚠️  Found $orphaned_count orphaned file(s) in target directory"
fi

# Check for files in SOURCE not present in TARGET
echo "---"
echo "⚠️  Checking for missing links in target directory..."
missing_count=0
for source_file in "$SOURCE_DIR"/*.prompt.md; do
  if [ -f "$source_file" ]; then
    filename=$(basename "$source_file")
    target_file="$TARGET_DIR/$filename"
    
    if [ ! -L "$target_file" ]; then
      echo "  ⚠️  WARNING: $filename exists in source but NOT linked in target"
      missing_count=$((missing_count + 1))
    fi
  fi
done

if [ $missing_count -eq 0 ]; then
  echo "  ✓ All source files have corresponding links in target"
else
  echo "  ⚠️  Found $missing_count missing link(s) in target directory"
fi
```

## Result:
After reviewing the dry-run output and confirming, all prompt files will be accessible to VS Code Insiders through symbolic links, allowing you to keep a single source of truth in your dotfiles.

## Workflow:
1. **Review**: See the dry-run output showing which links will be created and which already exist
2. **Confirm**: User reviews and approves the changes
3. **Execute**: Run the real command to create the symbolic links
4. **Verify**: Confirm all links were created successfully

````
