#!/bin/bash

# Directory where the symlinks will point to
themes_dir=${HOME}/homebrew/themes/

# Loop through each directory
for repo in ${@}; do
  for dir in ${repo}/*/; do
    # Check for any theme folder
    if [ -d "${dir}" ] && [ -f "${dir}/theme.json" ]; then
      # Get the name of the theme
      theme_name=$(jq -r '.name' "${dir}/theme.json")
      link_path="${themes_dir}${theme_name}"
      # Create the symlink in the target directory
      unlink "${link_path}" 2> /dev/null
      ln -sT "$(realpath "${dir}")" "${link_path}"
      echo "Link: "${dir}" -> ${link_path}"
    fi
  done
done
