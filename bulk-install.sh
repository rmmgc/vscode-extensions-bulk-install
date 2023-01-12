#!/bin/bash

# Bulk install for VS Code extensions
#
# How it works #
# Script takes a list of extensions provided via .txt file and
# installs them. It will loop over file contents line by line
# so it is important to properly prepare the file.
#
# Prepare extensions list .txt file #
# Create .txt file with all VS Code extensions listed in there.
# Make sure all extensions are added by extension ID which is
# in ${publisher}.${name} format. Every extension should be
# separated with new line.
#
# Copyright (c) 2022 Ramo Mujagic <mujagic.ramo@gmail.com>
# -------------------------------------------------------------

# Colors used for logs
NC='\033[0m'          # Reset color
GREEN='\033[0;32m'    # Green color
RED='\033[0;31m'      # Red color

print_green () {
  message=$1
  printf "${GREEN}${message}${NC}\n"
}

print_red () {
  message=$1
  printf "${RED}${message}${NC}\n"
}

# Check for code command
# VS Code must be installed for script to work properly
if ! command -v code &> /dev/null
then
    print_red "Could not detect code command on your system.\n❌ Aborting."

    printf "💡 Check if VS Code is properly installed.\n"
    printf "💡 Make sure to add "$(print_green code)" command to the PATH\n"
    exit 1
fi

# Check if provided file exists
EXTENSIONS_FILE_PATH="$1"
if [ ! -f "$EXTENSIONS_FILE_PATH" ]; then
  print_red "File, on path $EXTENSIONS_FILE_PATH, could not be found.\n❌ Aborting."
  exit 1
fi

# File is expected to be in .txt format
if [[ "$EXTENSIONS_FILE_PATH" != *.txt ]]; then
  print_red "File, on path $EXTENSIONS_FILE_PATH, does not have correct format.\n❌ Aborting."
  printf "💡 Make sure that provided file has $(print_green .txt) extension/format.\n"
  exit 1
fi

# Get currently installed extensions
INSTALLED_EXTENSIONS=$(code --list-extensions)

# Loop over file contents line by line and try to install extensions
while read -r extension_name; do
  printf "🔧 Working on "$(print_green $extension_name)" extension.\n"

  if [[ $INSTALLED_EXTENSIONS == *"$extension_name"* ]]; then
    printf "✅ Extension already installed.\nSkipping further steps.\n\n"
    continue
  fi

  printf "Running: code --install-extension "$extension_name".\n"
  code --install-extension "$extension_name"

  if [ $? -eq 0 ]; then
    print_green "✅ Extension installed successfully.\n"
  else
    print_red "❌ Extension installation failed."
    printf "💡 Check the logs above to get more informations about error.\n\n"
  fi
done < "$EXTENSIONS_FILE_PATH"

printf "💡 Check the logs above for detailed report.\n"
print_green "🎉 Successfully finished."
