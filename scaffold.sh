#!/bin/bash
set -e

export FLASK_EXAMPLE=flask-examples
export WORKSPACE=$(pwd)

read -p "App name: " APPNAME </dev/tty
export APPNAME

read -p "Frontend toolkit? (y/n) " HAS_TOOLKIT </dev/tty
export HAS_TOOLKIT

export TEMP=$(mktemp -d -t python-flask-scaffold-XXXXXX) 

curl -L https://github.com/LandRegistry/flask-examples/archive/master.zip -o $TEMP/master.zip
unzip $TEMP/master -d $TEMP
mv $TEMP/flask-examples-master $WORKSPACE/$APPNAME

echo "Renaming the application proper"
# app name proper is same as project name
mv $WORKSPACE/$APPNAME/appname $WORKSPACE/$APPNAME/$APPNAME

cd $WORKSPACE/$APPNAME
rm README.md
echo "# $APPNAME" > README.md
echo "This app was created using the scaffolder at https://github.com/LandRegistry/flask-example-scaffold" >> README.md
git init
git add -A .
git commit -m "scaffold: init"
cd $WORKSPACE

if [ "$HAS_TOOLKIT" == "y" ] ; then
  rm -rf $WORKSPACE/$APPNAME/$APPNAME/static/govuk_toolkit 
  cd $WORKSPACE/$APPNAME
  git submodule add https://github.com/alphagov/govuk_frontend_toolkit.git $APPNAME/static/govuk_toolkit
  git add -A .
  git commit -m "scaffold: add frontend toolkit"
  cd $WORKSPACE
fi

for f in $(find $WORKSPACE/$APPNAME -type f) ; do
  perl -pi -e 's/appname/$ENV{APPNAME}/g' $f
done

cd $WORKSPACE/$APPNAME
git add -A .
git commit -m "scaffold: rename app proper"
cd $WORKSPACE

cat <<EOF
Done. App at $WORKSPACE/$APPNAME

>> TODO

cd $WORKSPACE/$APPNAME
git status
# git add / git commit / etc
# git remote add origin git@your-remote.com/$APPNAME.git
virtualenv .virtualenv
source .virtualenv/bin/activate
pip install -r requirements.txt
./run.sh
EOF

rm -rf $TEMP
