#!/bin/bash

set -eux

# Never enable autocrlf
git config --system core.autocrlf false

# Explicity specify the default eol to `LF`
git config --system core.eol lf

# Always rebase on pull operations, never merge.
git config --system pull.rebase true

# `fetch` will always run prune, so you never need to
git config --system remote.origin.prune true

# Adds color when showing blocks of code that moved by remain unchanged
git config --system diff.colorMoved zebra

# Set vim as the default editor. Modify as desired.
git config --system core.editor vim

# Configure `main` as default branch
git config --system init.defaultBranch main
