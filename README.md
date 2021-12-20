WeeChat IRC Client
==================

* Alpine-based Docker image for WeeChat built every time there is a new release

* Compiled from source; does not use .apks, which could be older versions

* Multi-architecture builds: x86_64, armv7 and arm64

* Includes [python-potr](https://pypi.org/project/python-potr/) module for encrypted Off-The-Record
  messaging

* The less commonly used Guile, PHP and Tcl plugins are disabled by default, but they can
  easily be enabled by editing the Dockerfile and building your own image

#### Enable/disable plugins:

* **To enable Guile (Scheme):**
Uncomment guile-dev (23) and guile (44) and comment out line 64

* **To enable PHP:**
Uncomment php-dev (26), argon2-dev (27), libxml2-dev (28) and php-embed (47) and comment out line 67

* **To enable Tcl:**
Uncomment tcl-dev (31) and tcl (51) and comment out line 70

* **To disable Aspell:**
Comment out aspell-dev (32), aspell-libs (52) and aspell-en (53). 
[Or you can add additional language dictionaries](https://ftp.gnu.org/gnu/aspell/dict/0index.html)

### To run, paste this:

    $ docker run --rm -it \
        --name weechat \
        --log-driver none \
        -e UID=$(id -u) -e GID=$(id -g) \
        -p 9001:9001 \
        -v /etc/hosts:/etc/hosts:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -v "${HOME}":/weechat \
        eggbean/weechat

Configuration and data files are now located at `~/.config` and `~/.local/share`
(v3.2 onwards). (If they doesn't exist, they will be created with default settings.)

Once up and running, use ```ctrl-p```, ```ctrl-q``` to detach from the session and ```docker attach
weechat``` to reattach.

### Contact:

Use the [GitHub Issues](https://github.com/eggbean/docker-weechat/issues) page.
