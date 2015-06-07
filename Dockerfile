FROM ubuntu:14.04
MAINTAINER Stefan Berggren <nsg@nsg.cc>

ENV VERSION 1.0.35
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget ruby-dev libssl-dev zlib1g-dev e2fslibs-dev make
RUN gem install fpm --no-ri --no-rdoc
RUN mkdir /build
WORKDIR /build

RUN wget https://www.tarsnap.com/download/tarsnap-autoconf-$VERSION.tgz
RUN wget https://www.tarsnap.com/download/tarsnap-sigs-$VERSION.asc

RUN wget https://www.tarsnap.com/tarsnap-signing-key.asc
RUN gpg --import tarsnap-signing-key.asc
RUN gpg --decrypt tarsnap-sigs-$VERSION.asc | tee out
RUN awk '/SHA256/{print $4"  "$2}' out | tr -d '()' | sha256sum -c -

RUN tar xfv tarsnap-autoconf*.tgz
RUN cd tarsnap-autoconf* && ./configure
RUN cd tarsnap-autoconf* && make all install clean

CMD fpm -s dir -t deb -v $VERSION -n tarsnap \
	/usr/local/bin/tarsnap* \
	/usr/local/etc/tar* \
	/usr/local/share/man/man*/tar*
