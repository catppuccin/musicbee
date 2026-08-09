#!/usr/bin/env bash

if [[ ! -f templates/palette.sh.tera ]]; then
    echo "Run this script from the repository root." >&2
    exit 1
fi

mkdir -p .build
whiskers templates/palette.sh.tera
source .build/palette.sh
