#!/bin/bash

# Loop through all video files in the current directory
for file in *.{mp4,mkv,avi,mov,flv,wmv}; do
    if [[ -f "$file" ]]; then
        temp_file="${file%.*}_temp.${file##*.}"
        
        ffmpeg -i "$file" -map_metadata -1 -c:v copy -c:a copy -c:s copy "$temp_file"
        
        if [[ $? -eq 0 ]]; then
            rm "$file"
            mv "$temp_file" "$file"
            echo "metadata removed from $file"
        else
            rm -f "$temp_file"
            echo "failed to remove metadata from $file"
        fi
    fi
done

echo "metadata removal completed"