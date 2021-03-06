#!/bin/bash

set -e
FOLDER_NAME=$1

echo "Building website for: $FOLDER_NAME"
if [[ "$FOLDER_NAME" != "site-master" ]]; then
  echo "baseurl: /$FOLDER_NAME" > _config_prb.yml
  cat _config_prb.yml
  rake buildenprb
else
  echo "baseurl: ''" > _config_prb.yml
  rake buildesprb
  rake buildenprb
fi

