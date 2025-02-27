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
            # Extract the number from the beginning of the filename (if it exists)
            if [[ "$filename" =~ ^[0-9]+ ]]; then
                number="${BASH_REMATCH[0]}"
                new_filename="${folder_name}_${number}.wav"
            else
                # If the filename does not start with a number, keep the original name
                new_filename="$filename"
            fi

            # # Convert the file to mono and save it with the new filename
            # sox "$file" -c 1 "${mono_folder}/${new_filename}"
            # echo "Converted $file to mono and saved to ${mono_folder}/${new_filename}"
            
            # Convert the file to 16-bit, 48kHz mono and save it with the new filename
            sox "$file" -b 16 -r 48000 -c 1 "${mono_folder}/${new_filename}"
            echo "Converted $file to 16-bit, 48kHz mono and saved to ${mono_folder}/${new_filename}"
        fi
    done
done

echo "All conversions complete!"