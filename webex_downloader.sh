#!/bin/bash

__get_m3u8_link() {
    FILENAME=$1

    cat $FILENAME | \
    grep -o -E "<video.*src=\"(.*.m3u8)\">" | \
    sed -E "s/<video.*src=\"(.*.m3u8)\">/\1/"
}

__get_title() {
    FILENAME=$1

    cat $FILENAME | \
    grep -o -E "<span title=\"(.*)\".*class=\"recordingTitle\">" | \
    sed -E "s/.*title=\"(.*)\" class=\"recordingTitle\">/\1/"
}

__download_file() {
    URL=$1
    FILENAME=$2

    ffmpeg -i "$URL" \
        -c copy \
        -bsf:a aac_adtstoasc "$FILENAME"
}

_run_python_script() {
    EMAIL=$1
    CP=$2
    PASSWORD=$3
    shift 3

    ./s.py $EMAIL $CP $PASSWORD $@
}

_run_python_script $@

if [[ $? -ne 0 ]]; then
    echo "Could not download videos"
    exit 1
fi

files=($(pwd)/*.html)
renamed_files=()

for file in "${files[@]}"
do
    TITLE=$(__get_title $file)
    LINK=$(__get_m3u8_link $file)
    NFILE="$(pwd)/$TITLE"
    renamed_files+=( "$NFILE" )
    mv $file $NFILE
    echo $LINK > $NFILE
done

for file in "${renamed_files[@]}"
do
    _download_file "$(cat $file)" "${file}.mp4" 
done

exit 0