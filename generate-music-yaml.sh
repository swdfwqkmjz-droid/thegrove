#!/bin/bash

# Set the folder containing your audio files
MUSIC_DIR="./assets/music"

# Loop through each .m4a or .mp3 file
for file in "$MUSIC_DIR"/*.{m4a,mp3}; do
  [ -e "$file" ] || continue  # Skip if no match

  # Extract filename and title
  filename=$(basename "$file")
  title="${filename%.*}"
  title_pretty=$(echo "$title" | sed -E 's/[-_]/ /g' | sed -E 's/\b\w/\u&/g')

  # Get duration in seconds using ffprobe
  duration_raw=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file")
  duration_seconds=$(printf "%.0f" "$duration_raw")
  duration_formatted=$(printf "%d:%02d" $(($duration_seconds / 60)) $(($duration_seconds % 60)))

  # Output front matter
  echo "---"
  echo "title: \"$title_pretty\""
  echo "m4a: \"/assets/music/$filename\""
  echo "duration: \"$duration_formatted\""
  echo "status: sketch"
  echo "category: piece"
  echo "tags: []"
  echo "date: $(date +%Y-%m-%d)"
  echo "---"
  echo ""
done
