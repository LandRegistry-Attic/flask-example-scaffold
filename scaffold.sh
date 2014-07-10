#!/bin/bash
set -e

FLASK_EXAMPLE=flask-examples

read -p "App name: " APPNAME </dev/tty
export APPNAME

TEMP=$(mktemp -d -t python-flask-scaffold-XXXXXX) 
git clone https://github.com/LandRegistry/$FLASK_EXAMPLE  $TEMP/$FLASK_EXAMPLE

cd $TEMP/$FLASK_EXAMPLE
git submodule init
git submodule update

cd -
mv $TEMP/$FLASK_EXAMPLE $APPNAME

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
