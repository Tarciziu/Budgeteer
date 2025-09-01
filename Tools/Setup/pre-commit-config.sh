#!/bin/sh

# ---------------------------------
# Pre-commit check.
# ---------------------------------

HOOKS_DIRECTORY_LOCATION=$PWD"/.git/hooks/"
PRE_COMMIT_HOOK_LOCATION=$PWD"/.git/hooks/pre-commit"
PRE_COMMIT_TEMPLATE=$PWD"/Tools/Setup/pre-commit-template.sh"

# The key used to store the information related to the pre-commit hook metadata to the respective file.
PRE_COMMIT_VERSION_KEY="com.Budgeteer.metadata.preCommitVersion"

# This property represents the current version of the pre-commit hook.
# Any hook which is not updated to this version will be overriten at setup phase.
CURRENT_PRE_COMMIT_VERSION="1.0.0"


installPreCommit() {
  # We just copy-paste the template in the dedicate directory for hooks and make it executable.
  cp $PRE_COMMIT_TEMPLATE $PRE_COMMIT_HOOK_LOCATION
  xattr -w $PRE_COMMIT_VERSION_KEY $CURRENT_PRE_COMMIT_VERSION $PRE_COMMIT_HOOK_LOCATION
  chmod +x $PRE_COMMIT_HOOK_LOCATION
  echo "Pre-commit hook installed"
}

validatePreCommitVersion() {
  # The versions of the pre-commit will be stored as metadata with a dedicated key.
  # If the existing pre-commit file does not contain any value for that key or contains a different value(outdated/altered),
  # we override the hook.
  STORED_PRE_COMMIT_VERSION=`xattr -p $PRE_COMMIT_VERSION_KEY $PRE_COMMIT_HOOK_LOCATION`

  # We compare the stored version of the pre-commit current version
  if [ "$STORED_PRE_COMMIT_VERSION"="$CURRENT_PRE_COMMIT_VERSION" ]
  then
    echo "Existing pre-commit hook is valid"
    return $EXIT_CODE_TOOL_ALREADY_INSTALLED
  else
    # If the versions are different we override the script
    echo "Existing pre-commit hook is invalid. Installig to the latest version......."
    installPreCommit
    return $EXIT_CODE_SUCCESFULL_UPDATE
  fi
}

checkPreCommit() {
  if [ -e $PRE_COMMIT_HOOK_LOCATION ]
  then
    echo "***********************************************************************"
    echo "A pre-commit hook is already installed. Proceeding with the validation"
    echo "***********************************************************************"
    validatePreCommitVersion
  else
    echo "***********************************************************************"
    echo "Pre-commit hook is missing. Installing the latest version"
    echo "***********************************************************************"
    installPreCommit
    return $EXIT_CODE_SUCCESS
  fi
}
