#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"
BUILDBOT="$DIR/buildbot"
MASTER="$BUILDBOT/master"
SLAVE="$BUILDBOT/slave"

if [ -d "$BUILDBOT" ]; then
  echo "ERROR: $BUILDBOT exists"
  exit 1
fi

sudo apt-get install buildbot buildbot-slave mercurial

mkdir -p "$BUILDBOT"
cd "$BUILDBOT"

buildbot create-master "$MASTER"
"$DIR/config.py" "$DIR/misc/buildbot.cfg.tmpl" > "$MASTER/master.cfg"

buildslave create-slave "$SLAVE" localhost:9989 ql-slave ql-pass
echo "Christoph Reiter <reiter.christoph@gmail.com>" > "$SLAVE/info/admin"