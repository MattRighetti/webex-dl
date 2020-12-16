# webex-dl
This tool will download the meeting recordings that you specify

**This tool is intended for students at Politecnico di Milano**

## Prerequisites
- Linux, macOS (this has not been tested on Windows)
- [`jq`](https://github.com/stedolan/jq)
- `ffmpeg`

## How to use
The best way you can use this tool

1. Move to the tool's folder
2. Put your webex meeting links in `links.txt`
3. Put the Cookie named `ticket` value in `ticket.txt` that you get when you login to webex
3. Execute this command

```sh
$ webex-dl
```