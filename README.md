WeeChat IRC Client
==================

* Tiny Alpine-based Docker images for WeeChat built every time there is a new release

* For the latest daily build: `docker pull eggbean/weechat:dev`

* Compiled from source; does not use .apks, which could be older versions

* Multi-architecture builds: x86_64, arm and arm64

* Includes all plugins apart from JavaScript and PHP (not used by any scripts in [the scripts repository](https://weechat.org/scripts/)).

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

Configuration and data files are located at `~/.config/weechat` and `~/.local/share/weechat` (If they don't exist, they'll be created with default settings).

Once up and running, use ```ctrl-p```, ```ctrl-q``` to detach from the session and ```docker attach
weechat``` to reattach.

### Contact:

Use the [GitHub Issues](https://github.com/eggbean/docker-weechat/issues) page.
