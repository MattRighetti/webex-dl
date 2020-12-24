# webex-dl
This tool will download the meeting recordings that you specify

**This tool is intended for students at Politecnico di Milano**

## Prerequisites
- Linux, macOS (this has not been tested on Windows)
- [`jq`](https://github.com/stedolan/jq)
- `ffmpeg`

## Commands
```
Usage: webex-dl [ -f links_file ] [ -tf ticket_file ] [ -t ticket ] [ -i links ]

       Command summary:
       -f, --file             Use links contained in file
       -t, --ticket           Input ticket from command line
       -tf, --ticket-file     Use ticket contained in file
       -i                     Input links from command line and don't use file input
       -p                     Launches specified number of processes
       -v                     Output verbose logs
       -h, --help             Print info about the program
```

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
$ webex-dl -tf ticket.txt -f links.txt
```

You can also provide links directly from command line

```sh
$ webex-dl -tf ticket.txt -i link1 link2 link3 ...
```

And you can also pass the ticket directly from command line

```sh
$ webex-dl -t ticket_value -i link1 link2 link3 ...
```

## Multiprocess
This tool can run multiple downloads in parallel by using multiprocessing, this feature is intended only for people that have a good internet connection.

You can specify how many parallel downloads you want by using the `-p` command flag

This command will download 5 meetings concurrently

```sh
$ webex-dl -tf ticket.txt -f links.txt -p 5
```

If everything executes correctly you will get something similar to this
![webex-dl](screenshots/webex-dl.png)