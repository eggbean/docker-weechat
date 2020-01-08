FROM alpine

ENV TERM=screen-256color
ENV LANG=C.UTF-8
ENV UID=1000
ENV GID=1000

ADD run.sh /
	
RUN BUILD_DEPS=" \
	cmake \
	build-base \
	libcurl \
	libintl \
	zlib-dev \
	curl-dev \
	gnutls-dev \
	ncurses-dev \
	libgcrypt-dev \
	ca-certificates \
	gettext-dev \
#	guile-dev \
#	lua-dev \
	perl-dev \
#	php-dev \
#	argon2-dev \
#	libxml2-dev \
	python3-dev \
	ruby-dev \
#	tcl-dev \
	aspell-dev \
	jq \
	tar" \
	&& apk -U upgrade && apk add --no-cache \
	${BUILD_DEPS} \
	gnutls \
	ncurses \
	libgcrypt \
	su-exec \
	curl \
	shadow \
#	guile \
#	lua-libs \
	perl \
#	php-embed \
	python3 \
	ruby-libs \
#	tcl \
	aspell-libs \
	aspell-en \
	&& update-ca-certificates \
	&& WEECHAT_TARBALL="$(curl -sS https://api.github.com/repos/weechat/weechat/releases/latest | jq .tarball_url -r)" \
	&& curl -sSL $WEECHAT_TARBALL -o /tmp/weechat.tar.gz \
	&& mkdir -p /tmp/weechat/build \
	&& tar xzf /tmp/weechat.tar.gz --strip 1 -C /tmp/weechat \
	&& cd /tmp/weechat/build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
		-DENABLE_JAVASCRIPT=OFF \
		-DENABLE_GUILE=OFF \
		-DENABLE_LUA=OFF \
#		-DENABLE_PERL \
		-DENABLE_PHP=OFF \
#		-DENABLE_PYTHON=OFF \
#		-DENABLE_RUBY=OFF \
		-DENABLE_TCL=OFF \
#		-DENABLE_RELAY=OFF \
#		-DENABLE_SPELL \
	&& make && make install \
	&& mkdir /weechat \
	&& addgroup -g $GID -S weechat \
	&& adduser -u $UID -D -S -h /weechat -s /sbin/nologin -G weechat weechat \
	&& apk del ${BUILD_DEPS} \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /tmp/*

VOLUME /weechat

WORKDIR /weechat

EXPOSE 9001

ENTRYPOINT ["/run.sh"]
CMD ["--dir /weechat"]
