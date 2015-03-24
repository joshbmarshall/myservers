#!/bin/bash

[ -e "`which berks`" ] || yum install -y https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.3.6-1.x86_64.rpm
[ `berks -v` == "3.2.3" ] || yum install -y https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.3.6-1.x86_64.rpm

# Get directory of this script

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

SOLOFILE="$DIR/solo.rb"

echo "file_cache_path \"$DIR\"" > $SOLOFILE
echo "json_attribs \"$DIR/config.json\"" >> $SOLOFILE
echo 'cookbook_path [' >> $SOLOFILE
echo '	"/tmp/berkshelf",' >> $SOLOFILE
echo "	\"$DIR/cookbooks\"" >> $SOLOFILE
echo ']' >> $SOLOFILE
echo "verify_api_cert true" >> $SOLOFILE

rm -fr /tmp/berkshelf
berks install
berks update
berks vendor /tmp/berkshelf

chef-solo -c "$SOLOFILE"
