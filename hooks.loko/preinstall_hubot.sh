#!/usr/bin/env bash

set -xeo pipefail

install_dir=`dirname $0`

chown -R produser $install_dir

