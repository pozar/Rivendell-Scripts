#!/bin/sh
# A script to import RSS feeds.  It will grab the first file in the list.
# This script is used to download Democracy Now! via the RSS feed.
# It changes to the download directory, moves other MP3s into 
# the "imported" subdirectory and then downloads the file from DN!.
# It then runs the rdimport script to move it into a specific cart 
# number for playback after the import is run.

# Working directory...
cd /audio/audio_to_import/DN/
# Clear out any MP3s...
mv /audio/audio_to_import/DN/*.mp3 /audio/audio_to_import/DN/imported
# Download latest DN mp3 to the current directory...
/usr/bin/curl -s 'https://www.democracynow.org/podcast.xml' | awk '/enclosure/{system("wget -nc "$2);exit}' FS=\"

FILE="/audio/audio_to_import/DN/*.mp3"
if ls $FILE 1> /dev/null 2>&1; then
    # Import DN Audio here...
    /usr/local/bin/rdimport --verbose --delete-cuts --to-cart=100 --segue-level=-10 DN /audio/audio_to_import/DN/*.mp3
    # Save the file...
    mv /audio/audio_to_import/DN/*.mp3 /audio/audio_to_import/DN/imported
else 
    echo "$FILE does not exist"
fi

