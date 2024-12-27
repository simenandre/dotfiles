#!/bin/bash

# Add directories to the PATH and prevent to add the same directory multiple times upon shell reload.
add_to_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Add ghq to PATH
add_to_path "$GOPATH/bin"
add_to_path "/Library/Frameworks/Firebird.framework/Resources/bin"

