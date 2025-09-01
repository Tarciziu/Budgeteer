#!/bin/bash

#
#  pre-commit-template.sh
#
#
#  Created by Adrian-Zoltan Herczeg on 31.08.2025.
#

echo ""
echo "********************************************************************"
echo "Running git pre-commit hook. Making sure that its a valid branch..."
echo "********************************************************************"

# This line is required to make sure it works on Apple Silicon.
if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Early check if the linter is installed.
if ! which swiftlint >/dev/null; then
  echo "ERROR: Could not run swiftlint. Please build the project first or ask a colleague for assistance."
  exit 1
fi

# Necessary for some external git clients.
ZSH_FLE_PATH="~/.zshrc"
if test -f "$ZSH_FLE_PATH"; then
  source ~/.zshrc
fi

# Check the branch
branch="$(git rev-parse --abbrev-ref HEAD)"

echo ""
echo "Current Branch: $branch"

if [ "$branch" = "main" ]; then
  echo "You can't commit directly to main branch"
  exit 1
fi

echo "The branch is valid, moving onto next step..."
echo ""


echo "*********************************************************"
echo "Running git pre-commit hook. Running Swift Lint... "
echo "*********************************************************"

# Export the necessary environment variables for commnd line interface working.
# For more details see https://github.com/realm/SwiftLint?tab=readme-ov-file#command-line-usage
count=0
for file_path in $(git diff --name-only --cached --diff-filter=d | grep ".swift$"); do
  export SCRIPT_INPUT_FILE_$count="$file_path"
  count=$((count + 1))
done
export SCRIPT_INPUT_FILE_COUNT=$count

if [ $count -eq 0 ]; then
    echo ""
    echo "No files to lint!"
    exit 0
fi

echo "Found $count lintable files! Linting now ..."
echo "*********************************************"
echo ""

swiftlint --fix --use-script-input-files --config $PWD"/Tools/SwiftLint/swiftlint-config.yml" &&
swiftlint --strict --use-script-input-files --config $PWD"/Tools/SwiftLint/swiftlint-config.yml"
RESULT=$?

for file_path in $(git diff --name-only --cached --diff-filter=d | grep ".swift$"); do
  git add $file_path
done

remaining_count=0
for file_path in $(git diff --name-only --cached --diff-filter=d); do
  remaining_count+=1
done

if [ $remaining_count -eq 0 ]; then
  echo ""
  echo "No changes to commit"
  exit 0
fi

if ! [ $RESULT -eq 0 ]; then
  echo ""
  echo "*********************************************************"
  echo "SwiftLint found violations it could not fix."
  echo "Please fix the issues manually and try to commit again"
  echo "*********************************************************"
  echo ""
  exit $RESULT
fi
