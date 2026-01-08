#!/usr/bin/env bash

set -eu

if [ ! -f /etc/lsb-release ]; then
    echo "ERROR: Could not determine distribution: /etc/lsb-release not found"
    exit 1
fi

. /etc/lsb-release
case "$DISTRIB_ID" in
Ubuntu)
    case "$DISTRIB_RELEASE" in
    24.04)
        profiles/ubuntu2404.sh
        ;;
    *)
        echo "WARNING: Unsupported Ubuntu release: $DISTRIB_RELEASE"
        ;;
    esac
    ;;
*)
    echo "WARNING: Unsupported distribution: $DISTRIB_ID"
    ;;
esac
