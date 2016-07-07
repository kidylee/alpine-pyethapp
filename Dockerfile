FROM alpine

MAINTAINER An Li kidylee@gmail.com

WORKDIR pyethapp

RUN apk add --no-cache --update python py-pip \
	&& apk add --no-cache --update --virtual .build-deps\
		alpine-sdk \
		make \
		g++ \
		musl-dev \
		autoconf \
		automake \
		libtool \
		libffi-dev \
		gmp-dev \
		python-dev \
		openssl-dev \
	&& git clone https://github.com/ethereum/pyethapp . \
	&& pip install pyethapp --no-cache-dir --editable . \
	&& apk del .build-deps \
	&& echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add --update --no-cache gmp leveldb

ENTRYPOINT [/usr/bin/pyethapp]
