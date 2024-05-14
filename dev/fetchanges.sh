#!/bin/bash

# GitHub repository URL
repo_url="https://github.com/octoposprime/op-infra.git"

# Branch name that currently using
branch="phase1"

# Directory to clone the repository into
clone_dir="$HOME/k8s/project/op-infra"

# Repository cloning or updating process
if [ ! -d "$clone_dir" ]; then
    echo "Repository not found locally. Cloning into $clone_dir..."
    git clone --branch "$branch" "$repo_url" "$clone_dir" --recursive
    cd "$clone_dir" || exit
else
    echo "Repository already exists. Fetching updates..."
    cd "$clone_dir" || exit
    git fetch origin
    git checkout "$branch"
    git pull origin "$branch"
fi

# Submodules update 
git submodule update --init --recursive

# Show changes
echo "Changes in repository:"
git log --oneline --decorate --graph -n 5

# Script completed message
echo "Repository is up to date in $clone_dir."

