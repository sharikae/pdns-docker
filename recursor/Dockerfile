FROM ubuntu:bionic
MAINTAINER Shota Harikae <mail@sorahane.me>

RUN { \
      echo "Package: pdns-*"; \
      echo "Pin: origin repo.powerdns.com"; \
      echo "Pin-Priority: 600"; \
    } > /etc/apt/preferences.d/pdns

RUN apt-get update && apt-get install -y curl sudo gnupg \
	&& curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo apt-key add - \
	&& echo "deb [arch=amd64] http://repo.powerdns.com/ubuntu bionic-rec-43 main" > /etc/apt/sources.list.d/pdns.list

RUN apt-get update && apt-get install -y \
	pdns-recursor \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 53 80
EXPOSE 53/udp

RUN mkdir -p /var/run/pdns-recursor/

CMD ["pdns_recursor", "--disable-syslog=yes", "--log-timestamp=no", "--local-address=0.0.0.0", "--daemon=no", "--setgid=pdns", "--setuid=pdns"]
