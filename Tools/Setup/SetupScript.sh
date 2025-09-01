#!/bin/sh

#  SetupScript.sh
#  
#
#  Created by Adrian-Zoltan Herczeg on 31.08.2025.
#

# PREPARATIONS
CONSTANTS_FILE_PATH=$PWD"/Tools/Setup/constants.sh"
PRE_COMMIT_CONFIG_FILE_PATH=$PWD"/Tools/Setup/pre-commit-config.sh"
source $CONSTANTS_FILE_PATH
source $PRE_COMMIT_CONFIG_FILE_PATH

# PATHS TO INSTALLATION SCRIPTS FOR TOOLS
SWIFTLINT_INSTALL_PATH="Tools/SwiftLint/SwiftLintInstall.sh"

# PERMISSIONS SETTINGS
chmod $DEFAULT_RUN_SCRIPT_PERMISSIONS_CODE $SWIFTLINT_INSTALL_PATH

# We will store the completion code of each script in order to check if some additional messages need to be shown.
exit_codes=()

# INSTALLATION COMMANDS
bash $SWIFTLINT_INSTALL_PATH
# This will save the exit code of the last operation in the corresponding array.
exit_codes+=($?)

checkPreCommit
exit_codes+=($?)

for exit_code in ${exit_codes[@]}; do
    echo $exit_code
    if [ $exit_code -eq $EXIT_CODE_FAILURE ]; then
        echo "warning: Errors appeared during the setup process. Please consult the build logs."
        break
    fi
done

for exit_code in ${exit_codes[@]}; do
    # We display the message only if, by running the script, something new was installed/configured.
    if [ $exit_code -eq $EXIT_CODE_SUCCESS ];
    then
        echo "warning: NOTE: Setup complete. Running installed scripts ..."
        break
    fi
done


# EXECUTION OF THE REGULAR RUN SCRIPTS
SWIFTLINT_RUN_SCIRPT_PATH=$PWD/"Tools/SwiftLint/SwiftLintRunScript.sh"
bash $SWIFTLINT_RUN_SCIRPT_PATH
