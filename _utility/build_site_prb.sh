#!/bin/bash
set -e
FOLDER_NAME=$1

CACHE_FOLDER="$(pwd)/site_cache/"
CACHE_ARTIFACT="${CACHE_FOLDER}site_cache.tar.gz"
SITE_COMPILATION='_site/'

if [ -f $CACHE_ARTIFACT ]; then
  echo "Uncompressing previous cached site"
  tar -xvzf $CACHE_ARTIFACT _site/
   rm -rf $CACHE_FOLDER
fi

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

echo "Making new cached site for later uploading"
mkdir -p $CACHE_FOLDER
tar --atime-preserve -pvczf $CACHE_ARTIFACT _site/
