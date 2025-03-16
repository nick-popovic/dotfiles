######
# Script: dot_install.sh
# OS: macOS
# Description: Recursively symlinks all files and directories from a given dotfiles directory
#              to a target directory, ensuring that existing files are removed if they are not symlinks.
# Usage: ./dot_install.sh <dotfiles_directory> <target_directory>
# Example: ./dot_install.sh ~/dotfiles ~
######

#!/bin/bash

# Ensure the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <dotfiles_directory> <target_directory>"
    exit 1
fi

# Assign command-line arguments to variables
DOTFILES_DIR="$1"
TARGET_DIR="$2"

# Ensure the dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory '$DOTFILES_DIR' does not exist."
    exit 1
fi

# Ensure the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Target directory '$TARGET_DIR' does not exist."
    exit 1
fi

# Function to create symlinks and handle conflicts
create_symlink() {
    src="$1"
    dest="$2"

    # If destination exists and is not a symlink, remove it
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Removing existing file/directory: $dest"
        rm -rf "$dest"
    fi

    # Ensure the parent directory exists
    mkdir -p "$(dirname "$dest")"

    # Create the symlink
    ln -sfn "$src" "$dest"
    echo "Symlinked: $src -> $dest"
}

# Export function for compatibility with `find -exec`
export -f create_symlink

# Loop through all files and directories in the dotfiles directory
# macOS `find` requires `-o` in parentheses for OR conditions
IFS='' # Preserve spaces and newlines in filenames
find "$DOTFILES_DIR" \( -type f -o -type d \) | while read -r file; do
    # Get the relative path from the dotfiles directory
    rel_path="${file#$DOTFILES_DIR/}"
    
    # Determine the target location
    dest="$TARGET_DIR/$rel_path"

    # Create the symlink
    create_symlink "$file" "$dest"
done

echo "All dotfiles from '$DOTFILES_DIR' have been symlinked to '$TARGET_DIR'!"
