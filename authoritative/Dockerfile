FROM ubuntu:xenial
MAINTAINER Shota Harikae <mail@sorahane.me>

RUN { \
      echo "Package: pdns-*"; \
      echo "Pin: origin repo.powerdns.com"; \
      echo "Pin-Priority: 600"; \
    } > /etc/apt/preferences.d/pdns

RUN apt-get update && apt-get install -y curl sudo \
	&& curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo apt-key add - \
	&& echo "deb [arch=amd64] http://repo.powerdns.com/ubuntu xenial-auth-42 main" > /etc/apt/sources.list.d/pdns.list

RUN apt-get update && apt-get install -y \
	mysql-client \
	pdns-server \
	pdns-backend-mysql \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY assets/sql/pdns.sql /pdns.sql
COPY assets/create_db.sh /usr/bin/
RUN chmod 755 /usr/bin/create_db.sh

EXPOSE 53 80
EXPOSE 53/udp

CMD ["/usr/sbin/pdns_server", "--guardian=yes", "--daemon=no"]
