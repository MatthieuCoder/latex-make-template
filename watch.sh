#!/bin/env bash

# We first generate the PDFs from the start
make all

# We then listen for changes
inotifywait -r -m -e modify . | 
   while read file_path file_event file_name; do 
    extension="${file_name##*.}"
    # If the changed file is a TEX file
    if [[ "$extension" ==  "tex" ]]
    then
        name="${file_name%%.*}"
        # We call the make target in order to build it
        make "$name.pdf"
    fi
   done
