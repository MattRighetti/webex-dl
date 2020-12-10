#!/bin/bash

source scriptUtils.sh

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

    infoln "Downloading $FILENAME"

    ffmpeg -i "$URL" \
        -c copy \
        -bsf:a aac_adtstoasc "$FILENAME" \
        1>/dev/null 2>&1

    if [[ $? -ne 0 ]]; then
        errorln "Couldn't download $FILENAME"
    else
        successln "$FILENAME successfully downloaded"
    fi
}

_run_python_script() {
    EMAIL=$1
    CP=$2
    PASSWORD=$3
    shift 3

    ./meeting_link_script.py $EMAIL $CP $PASSWORD $@
}

_run_python_script $@

if [[ $? -ne 0 ]]; then
    fatalln "Could not download videos"
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
    infoln "Created $NFILE"
done

for file in "${renamed_files[@]}"
do
    __download_file "$(cat $file)" "${file}.mp4"
done

exit 0