docker run --rm -it \
  --name weechat \
  --log-driver none \
  -e UID=$(id -u) -e GID=$(id -g) \
  -p 9001:9001 \
  -v /etc/hosts:/etc/hosts:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -v path/to/weechat/config:weechat \
  eggbean/weechat

# Replace '/srv/docker/weechat' with the path where your .weechat directory resides
# If it does not exist, it will be created using default settings
