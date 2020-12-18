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
2. Put your webex meeting links in `links.txt` (each link on a single line)
3. Get the value of the Cookie named `ticket`
    ![ticket](screenshots/ticket.png)
    - This is needed to access private videos that requires login credentials
4. Put the value of the Cookie in `ticket.txt`
5. Execute this command

```sh
$ webex-dl
```

If everything executes correctly you will get something similar to this
![webex-dl](screenshots/webex-dl.png)