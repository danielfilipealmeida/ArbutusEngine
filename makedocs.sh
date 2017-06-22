#!/bin/sh

#  makedocs.sh
#  ArbutusEngine
#
#  Created by Daniel Almeida on 10/03/17.
#

DOCUMENTATION_PATH="Documentation"
headerdoc2html -o $DOCUMENTATION_PATH src/Library/Engine/
cd $DOCUMENTATION_PATH
gatherheaderdoc .
