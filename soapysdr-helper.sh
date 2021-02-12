#!/bin/sh

set -e

if avahi-daemon -c; then
  SOAPY_REMOTE_IP_ADDRESS="${SOAPY_REMOTE_IP_ADDRESS:-[::]}"
  SOAPY_REMOTE_PORT="${SOAPY_REMOTE_PORT:-55132}"
  exec /usr/local/bin/SoapySDRServer --bind="${SOAPY_REMOTE_IP_ADDRESS}:${SOAPY_REMOTE_PORT}"
else
  exit 1
fi