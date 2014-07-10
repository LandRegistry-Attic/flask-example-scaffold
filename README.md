# What?

Scaffolds Python Flask [skeleton app]().

# How?

To create a new app (it will ask you ffor options, like app name):

    curl -L https://raw.githubusercontent.com/LandRegistry/flask-example-scaffold/master/scaffold.sh | bash

Sometimes Github caches stuff, even if changes were pushed, so bust it with ```?$(date +%s)```:

    curl -L "https://raw.githubusercontent.com/LandRegistry/flask-example-scaffold/master/scaffold.sh?$(date +%s)" | bash

The script is self-documenting and will tell you what to do next.

# TODO

Ask for more options:
 - has database?
 - has frontend? (use GDS frontend-toolkit for this)
 - etc
