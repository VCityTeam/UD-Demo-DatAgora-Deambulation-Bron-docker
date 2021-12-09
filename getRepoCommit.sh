#!/bin/sh

[ $# -ne 2 ] && echo "Usage: $0 <repo_url> <commitish>" && exit 1
repo=$1
commitish=$2

# Easy version:
#git clone $repo &&\
#git checkout $commitish

# Lightweight version:
dirname=$(basename $repo)
mkdir $dirname &&\
cd $dirname &&\
git init &&\
git remote add origin $repo &&\
git fetch --depth 1 origin $commitish &&\
git checkout FETCH_HEAD
