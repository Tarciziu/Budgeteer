#!/bin/sh

#  swiftlint.sh
#  
#
#  Created by Adrian-Zoltan Herczeg on 31.08.2025.
#
export PATH="$PATH:/opt/homebrew/bin"

if which swiftlint; then
    CONFIG_FILE_PATH=$PWD/"Tools/SwiftLint/swiftlint-config.yml"
    swiftlint --config $CONFIG_FILE_PATH
else
    echo "warning: Could not run swiftlint. Please check the logs for installation issues."
fi
