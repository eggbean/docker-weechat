WeeChat IRC Client
==================

* Automatically built Alpine-based Docker image for WeeChat

* Compiled from source; does not use .apks

* Rebuilt every time there is a new release

* Forked/fixed from [Dockerfile by jkaberg](https://hub.docker.com/r/jkaberg/weechat)

#### Additional features:

* Relay plugin enabled for use with the [Glowing Bear](https://www.glowing-bear.org/) web interface

* Includes [python-potr](https://pypi.org/project/python-potr/) module for encrypted Off-The-Record
  messaging

* Automatically sets timezone from host machine and uses its host file.

* Aspell spell-checker plugin enabled

* Shell, Perl, Python and Ruby plugins enabled. All other scripting plugins are also available,
  apart from the one for JavaScript

* The less commonly used Guile, Lua, PHP and Tcl plugins are disabled by default, but they can
  easily be enabled by editing the Dockerfile and building your own image

#### Enable/disable plugins:

* **To enable Guile (Scheme):**
Uncomment guile-dev (22) and guile (42) and comment out line 60

* **To enable Lua:**
Uncomment lua-dev (23) and lua-libs (43) and comment out line 61

* **To enable PHP:**
Uncomment php-dev (25), argon2-dev (26), libxml2-dev (27) and php-embed (45) and comment out line 63

* **To enable Tcl:**
Uncomment tcl-dev (30) and tcl (48) and comment out line 66

* **To disable Aspell:**
Comment out aspell-dev (31), aspell-libs (49) and aspell-en (50). 
[Or you can add additional language dictionaries](https://ftp.gnu.org/gnu/aspell/dict/0index.html)

### To run, paste this:

    $ docker run --rm -it \
        --name weechat \
        --log-driver none \
        -e UID=$(id -u) -e GID=$(id -g) \
        -p 9001:9001 \
        -v /etc/hosts:/etc/hosts:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -v path/to/weechat/config:weechat \
        eggbean/weechat

Replace ```path/to/weechat/config``` with the location which contains your ```.weechat``` config
directory. (If it doesn't exist, it will be created with default settings.)

Once up and running, use ```ctrl-p```, ```ctrl-q``` to detach from the session and ```docker attach
weechat``` to reattach.

### Contact:

Use the [GitHub Issues](https://github.com/eggbean/docker-weechat/issues) page.
