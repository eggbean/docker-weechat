FROM alpine:latest

ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV UID=1000
ENV GID=1000

ADD run.sh /

RUN set -eux; BUILD_DEPS=" \
	asciidoctor \
	cmake \
	curl \
	curl-dev \
	g++ \
	gcc \
	gettext-dev \
	gnutls-dev \
	libgcrypt-dev \
	make \
	ncurses-dev \
	pkgconf \
	zlib-dev \
	zstd-dev \
	aspell-dev \
	guile-dev \
	lua5.3-dev \
	perl-dev \
	# argon2-dev \
	# libxml2-dev \
	# php7-dev \
	python3-dev \
	ruby-dev \
	tcl-dev \
	jq \
	tar" \
	&& apk -U upgrade && apk add --no-cache \
	${BUILD_DEPS} \
	ca-certificates \
	gettext \
	gnutls \
	libcurl \
	libgcrypt \
	ncurses \
	ncurses-libs \
	ncurses-terminfo \
	zlib \
	zstd-libs \
	aspell-libs \
	aspell-en \
	guile \
	guile-libs \
	lua5.3-libs \
	perl \
	# php7-embed \
	python3 \
	ruby-libs \
	tcl \
	tzdata \
	su-exec \
	shadow \
	py3-websocket-client \
	fzf \
	fzf-tmux \
	git \
	&& update-ca-certificates \
	&& git clone https://github.com/weechat/weechat.git /tmp/weechat \
	&& mkdir /tmp/weechat/build \
	&& cd /tmp/weechat/build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=None \
		-DENABLE_MAN=ON \
		-DENABLE_JAVASCRIPT=OFF \
		-DENABLE_GUILE=ON \
		-DENABLE_LUA=ON \
		-DENABLE_PERL=ON \
		-DENABLE_PHP=OFF \
		-DENABLE_PYTHON=ON \
		-DENABLE_RUBY=ON \
		-DENABLE_TCL=ON \
		-DENABLE_RELAY=ON \
		-DENABLE_SPELL=ON \
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
