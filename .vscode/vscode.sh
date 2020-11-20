#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Install VSCode extensions
cat $DIR/extensions.list | grep -v '^#' | xargs -L1 code --install-extension
