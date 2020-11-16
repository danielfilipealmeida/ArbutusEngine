#!/bin/sh
echo "copying lib fmodex"
rsync -aved "$OF_LIBS_PATH"/fmodex/lib/osx/libfmodex.dylib "$TARGET_BUILD_DIR";

