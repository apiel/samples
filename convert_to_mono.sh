#!/bin/bash

# Directory containing the sample folders
SAMPLES_DIR="."

# Find all subdirectories in the samples folder
for folder in "$SAMPLES_DIR"/*/; do
    # Get the folder name without the path
    folder_name=$(basename "$folder")

    # Skip folders that already end with "_mono"
    if [[ "$folder_name" == *_mono ]]; then
        echo "Skipping $folder_name (already processed)"
        continue
    fi

    # Create the corresponding _mono folder
    mono_folder="${SAMPLES_DIR}/${folder_name}_mono"
    mkdir -p "$mono_folder"

    # Convert all WAV files in the folder to mono and save them in the _mono folder
    for file in "$folder"*.wav; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file")
            sox "$file" -c 1 "${mono_folder}/${filename}"
            echo "Converted $file to mono and saved to ${mono_folder}/${filename}"
        fi
    done
done

echo "All conversions complete!"
