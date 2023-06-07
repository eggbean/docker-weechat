docker run --rm -it \
  --name weechat \
  --log-driver none \
  -e UID=$(id -u) -e GID=$(id -g) \
  -p 9001:9001 \
  -v /etc/hosts:/etc/hosts:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -v "${HOME}":/weechat \
  eggbean/weechat:dev

if [ $TMUX ]; then { tmux rename-window weechat && tmux set -u automatic-rename; }; fi
