FROM gfjardim/cups:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN apt-get update \
 && apt-get upgrade -y \
 && cleanimage


CMD ["/sbin/my_init"]


VOLUME /config /etc/cups/ /var/log/cups /var/spool/cups /var/cache/cups

EXPOSE 631
