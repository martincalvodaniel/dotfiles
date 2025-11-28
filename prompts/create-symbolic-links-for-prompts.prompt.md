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
1. Check if the target directory exists; create it if necessary
2. List all `.prompt.md` files in the source directory
3. For each prompt file, create a symbolic link in the target directory
4. Skip any files that already have links (avoid duplicates)
5. Verify all links were created successfully

## Command:
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
All prompt files will be accessible to VS Code Insiders through symbolic links, allowing you to keep a single source of truth in your dotfiles.
