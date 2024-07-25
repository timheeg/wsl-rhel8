#!/bin/bash

set -eux

# 🧑‍💻 Set user global configuration, in `$HOME/.gitconfig`.

# Setup Git Credential Manager
# This works for developing on windows host workstations.
#
# See https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git#git-credential-manager-setup
#
git config --global credential.helper \
  "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
