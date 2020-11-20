#!/bin/bash

# Install VSCode extensions
cat extensions.list | grep -v '^#' | xargs -L1 code --install-extension