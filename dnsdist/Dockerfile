FROM debian:stretch
MAINTAINER Shota Harikae <mail@sorahane.me>

RUN { \
      echo "Package: dnsdist*"; \
      echo "Pin: origin repo.powerdns.com"; \
      echo "Pin-Priority: 600"; \
    } > /etc/apt/preferences.d/dnsdist

RUN apt-get update && apt-get install -y curl sudo gnupg \
	&& curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo apt-key add - \
	&& echo "deb [arch=amd64] http://repo.powerdns.com/debian stretch-dnsdist-14 main" > /etc/apt/sources.list.d/pdns.list

RUN apt-get update && apt-get install -y \
	dnsdist \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 53 80
EXPOSE 53/udp

RUN mkdir -p /var/run/dnsdist/

CMD ["/usr/bin/dnsdist", "--local", "0.0.0.0:53", "--supervised"]
