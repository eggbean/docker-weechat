WeeChat IRC Client
==================

* Alpine-based Docker image for WeeChat built every time there is a new release

* Compiled from source; does not use .apks, which could be older versions

* Multi-architecture builds: x86_64, armv7 and arm64

* Includes [python-potr](https://pypi.org/project/python-potr/) module for encrypted Off-The-Record
  messaging

* Includes all plugins apart from JavaScript.

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
(v3.2 onwards). (If they doesn't exist, they will be created with default settings)

Once up and running, use ```ctrl-p```, ```ctrl-q``` to detach from the session and ```docker attach
weechat``` to reattach.

### Contact:

Use the [GitHub Issues](https://github.com/eggbean/docker-weechat/issues) page.
