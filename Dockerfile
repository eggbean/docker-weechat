FROM alpine:3.15

ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV UID=1000
ENV GID=1000
ENV PIP_ROOT_USER_ACTION=ignore

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
	py3-pip \
	ruby-libs \
	tcl \
	tzdata \
	su-exec \
	shadow \
	&& update-ca-certificates \
	&& pip3 install --upgrade pip \
	&& pip3 install --upgrade wheel \
	&& pip3 install --upgrade python-potr \
	&& WEECHAT_TARBALL="$(curl -sS https://api.github.com/repos/weechat/weechat/releases/latest | jq .tarball_url -r)" \
	&& curl -sSL $WEECHAT_TARBALL -o /tmp/weechat.tar.gz \
	&& mkdir -p /tmp/weechat/build \
	&& tar xzf /tmp/weechat.tar.gz --strip 1 -C /tmp/weechat \
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
