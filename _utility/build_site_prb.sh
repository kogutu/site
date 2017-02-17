#!/bin/bash
set -e
FOLDER_NAME=$1

[ -f site_cache/site_cache.tar.gz ] && tar -xvzf site_cache.tar.gz _site/
rm -rf site_cache/*

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


mkdir -p site_cache/
tar --atime-preserve -pczf site_cache/site.tar.gz _site/
