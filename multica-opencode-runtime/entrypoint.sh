#!/bin/sh
set -e

if [ -n "$MULTICA_SERVER_URL" ]; then
  ./multica config set server_url $MULTICA_SERVER_URL
else
  echo "MULTICA_SERVER_URL not set!"
  exit 1
fi

if [ -n "$MULTICA_APP_URL" ]; then
  ./multica config set server_url $MULTICA_APP_URL
else
  echo "MULTICA_APP_URL not set!"
  exit 1
fi

if [ -n "$MULTICA_LOGIN_TOKEN" ]; then
  ./multica login --token $MULTICA_LOGIN_TOKEN
else
  echo "MULTICA_LOGIN_TOKEN not set!"
  exit 1
fi

./multica daemon start --foreground
