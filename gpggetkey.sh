#!/bin/bash

out=$(mktemp)
err=$(mktemp)

gpg --status-fd=2 --no-verbose --quiet --batch --output - --verify $@ 2>$err 1>$out

if grep "NO_PUBKEY" $err &>/dev/null; then
  key=$(grep --color=none "RSA key ID" $err | perl -pe 's/^.+RSA key ID (.+)$/$1/')

  gpg --no-verbose --keyserver pgp.mit.edu --recv-keys $key &>/dev/null

  gpg --status-fd=2 --no-verbose --quiet --batch --output - --verify $@
else
  cat $out
  cat $err
fi

rm $out $err &>/dev/null
