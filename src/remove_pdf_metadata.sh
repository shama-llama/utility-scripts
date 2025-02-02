#!/bin/bash

# Loop through all PDF files in the current directory
for file in *.pdf; do
    if [[ -f "$file" ]]; then
        temp_file="${file%.*}_temp.pdf"
        
        exiftool -all:all= -o "$temp_file" "$file"
        
        if [[ $? -eq 0 ]]; then
            rm "$file"
            mv "$temp_file" "$file"
            echo "metadata removed from $file"
        elses
            rm -f "$temp_file"
            echo "failed to remove metadata from $file"
        fi
    fi
done

echo "metadata removal completed"