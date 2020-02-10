Dockerfile for WeeChat IRC Client
===================

This is an automatically built Alpine Docker image for WeeChat. It will rebuild every time there is a new release on
 [Github](https://github.com/weechat/weechat/releases) or when the [base image](https://hub.docker.com/_/alpine/) gets
 updated.  Most other WeeChat Dockerfiles use the .apk packages in the Alpine repository, which are usually older
 versions.

It's based on the [Dockerfile by jkaberg](https://github.com/jkaberg/dockerfiles/tree/master/weechat), which no longer
 compiles, so this is updated to work with more recent releases of WeeChat.  Also, additional plugins can be chosen, so
 that every WeeChat script plugin can be added, apart from the one for JavaScript.

The less commonly used Guile (Scheme), Lua, PHP and Tcl plugins are disabled by default, to save a bit of memory and
 disk space, but they can easily be enabled.

### Enable/disable plugins:

* **To enable Guile (Scheme):**
Uncomment guile-dev (22) and guile (42) and comment out line 59.

* **To enable Lua:**
Uncomment lua-dev (23) and lua-libs (43) and comment out line 60.

* **To enable PHP:**
Uncomment php-dev (25), argon2-dev (26), libxml2-dev (27) and php-embed (45) and comment out line 62.

* **To enable Tcl:**
Uncomment tcl-dev (30) and tcl (48) and comment out line 65.

* **To disable Aspell:**
Comment out aspell-dev (32), aspell-libs (49) and aspell-en (50).
[Or you can add additional language dictionaries.](https://ftp.gnu.org/gnu/aspell/dict/0index.html)

### Run:

To run it, simply use ```docker run```:

``` docker run -it --name weechat -e UID=1000 -e GID=1000 -v path/to/weechat/config:/weechat eggbean/weechat```

or docker-compose: 
  

      weechat:
        image: eggbean/weechat
        restart: always
        stdin_open: true
        tty: true
        volumes:
          - /path/to/weechat/config:/weechat
        environment:
          - 'UID=1000'
          - 'GID=1000'
        networks:
          - some_network

Once up and running, use ```ctrl-p```, ```ctrl-q``` to detach from the session and ```docker attach weechat``` to
reattach.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk1MTcwOTAyNV19
-->