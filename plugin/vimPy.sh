#!/bin/bash
FILEPATH=$1
echo "$FILEPATH" >> ~/pyout
#gstdbuf -o0 -e0 python $FILEPATH -u > pyout 2>&1 &
gstdbuf -o0 -e0 python $FILEPATH -u >> ~/pyout 2>&1
echo "~~finished running~~" >> ~/pyout
