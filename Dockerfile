FROM ubuntu:xenial
MAINTAINER Patrick Oberdorf <patrick@oberdorf.net>

COPY assets/apt/preferences.d/pdns /etc/apt/preferences.d/pdns
RUN apt-get update && apt-get install -y curl sudo \
	&& curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo apt-key add - \
	&& echo "deb [arch=amd64] http://repo.powerdns.com/ubuntu xenial-auth-42 main" > /etc/apt/sources.list.d/pdns.list

RUN apt-get update && apt-get install -y \
	wget \
	netcat-openbsd \
	git \
	mysql-client \
	pdns-server \
	pdns-backend-mysql \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -rf /etc/powerdns/pdns.d/

COPY assets/pdns/pdns.conf /etc/powerdns/pdns.conf
COPY assets/pdns/pdns.d/ /etc/powerdns/pdns.d/
COPY assets/mysql/pdns.sql /pdns.sql
COPY entrypoint.sh /entrypoint.sh

EXPOSE 53 80
EXPOSE 53/udp

CMD ["/bin/bash", "/entrypoint.sh"]
