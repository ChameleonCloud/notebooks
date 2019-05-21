#!/usr/bin/env bash

echo "Setting up experimental environment"
echo
echo "**********************************************"
echo "** Note: this wouldn't be necessary if      **"
echo "** I was using a saved disk image snapshot! **"
echo "**********************************************"
echo

PACKAGES=(stress-ng)

yum makecache
sudo yum install -y "${PACKAGES[@]}"
