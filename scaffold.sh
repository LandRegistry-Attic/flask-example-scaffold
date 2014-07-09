#!/bin/bash

APPNAME=${1:-skeletonapp}
export APPNAME

TEMP=$(mktemp -d -t python-flask-scaffold-XXXXXX) 
curl -L https://github.com/LandRegistry/flask-examples/archive/master.zip -o $TEMP/master.zip
unzip $TEMP/master -d $TEMP

mv $TEMP/flask-examples-master $APPNAME

echo "Renaming the application proper"
mv $APPNAME/appname $APPNAME/$APPNAME

for f in $(find $APPNAME -type f) ; do
  perl -pi -e 's/appname/$ENV{APPNAME}/g' $f
done

echo "Done. App at $(pwd)/$APPNAME"
echo
echo ">> TODO"
echo
echo "cd $APPNAME"
echo "virtualenv .virtualenv"
echo "source .virtualenv/bin/activate"
echo "pip install -r requirements.txt"
echo "./run.sh"

rm -rf $TEMP
