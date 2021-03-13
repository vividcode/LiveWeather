#!/bin/bash
echo "Arguments passed: " $1 $2 $3

export BASE_URL_DEV=$1
export BASE_URL_PROD=$2
export SUPPORT_URL=$3


gyb --line-directive '' -o $PWD/Gibberish.swift Gibberish.swift.gyb