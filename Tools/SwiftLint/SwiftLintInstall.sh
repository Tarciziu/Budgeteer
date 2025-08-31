#!/bin/sh

#  SwiftLintInstall.sh
#  
#
#  Created by Adrian-Zoltan Herczeg on 31.08.2025.
#  

export PATH="$PATH:/opt/homebrew/bin"
CONFIG_FILE_PATH=$PWD/"Tools/SwiftLint/swiftlint-config.yml"

if which swiftlint;
then
    echo "Swiftlint is already installed"
    exit $EXIT_CODE_TOOL_ALREADY_INSTALLED
else
    echo "warning: swiftlint not installed. Attempting to install swiftlint ia HomeBrew"
    brew install swiftlint
    if which swiftlint;
    then
        echo "warning: NOTE: Swiftlint installed succesfully !"
        chmod $DEFAULT_RUN_SCRIPT_PERMISSIONS_CODE $CONFIG_FILE_PATH
        exit $EXIT_CODE_SUCCESS
    else
        echo "warning: swiftlint could not be installed. Please consult the instalation guide or ask a developer for assistance."
        exit $EXIT_CODE_FAILURE
    fi
fi
