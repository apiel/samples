#!/bin/bash

# Directory containing the sample folders
SAMPLES_DIR="."
OUTPUT_DIR="${SAMPLES_DIR}/all"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Find all subdirectories in the samples folder
for folder in "$SAMPLES_DIR"/*/; do
    folder_name=$(basename "$folder")

    # Skip folders that end with "_mono" or the "all" folder itself
    if [[ "$folder_name" == *_mono || "$folder_name" == "all" ]]; then
        echo "Skipping $folder_name"
        continue
    fi

    # Process all WAV files in the folder
    for file in "$folder"*.wav; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file")

            # Extract number prefix (if any)
            if [[ "$filename" =~ ^[0-9]+ ]]; then
                number="${BASH_REMATCH[0]}"
                new_filename="${folder_name}_${number}.wav"
            else
                new_filename="${folder_name}_${filename}"
            fi

            # Copy the file (preserving stereo)
            cp "$file" "${OUTPUT_DIR}/${new_filename}"
            echo "Copied $file → ${OUTPUT_DIR}/${new_filename}"
        fi
    done
done

echo "✅ All files copied to '${OUTPUT_DIR}'!"
