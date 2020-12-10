# webex-dl
This tool will use your browser to get the `m3u8` link to the meeting and then uses `ffmpeg` to download it.

**This tool is intended for students at Politecnico di Milano**, if you're using this tool and you are not a student you'll have to adapt the login process to your needs.

**This tool works just with Safari since it's the only browser that exposes direct links to `.m3u8` files**

## Prerequisites
- Linux, macOS (this has not been tested on Windows)
- Safari Browser
- Python

### Safari Setup
1. Activate Developer setting (Safari > Preferences > Advanced > Show Develop menu in menu bar)
2. Activate Remote Automation (Safari > Develop > Allow Remote Automation)

## Python Packages
- Selenium

## How to use
The best way you can use this tool

1. Move to the tool's folder
2. Put your webex meeting links in a file, i.e. `links.txt`
3. Execute this command

```sh
cat links.txt | xargs ./webex-dl name.lastname@mail.polimi.it codicepersona polimi_password
```
**Note that codicepersone@polimi.it will not work**

### Alternative
You could alternatively just run

```sh
./webex-dl name.lastname@mail.polimi.it codicepersona polimi_password \
[meeting_link1] \
[meeting_link2] \
...
[meeting_linkN]
```