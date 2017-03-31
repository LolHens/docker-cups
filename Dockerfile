FROM gfjardim/cups:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


RUN apt-get update \
 && apt-get upgrade -y \
 && cleanimage


CMD ["/sbin/my_init"]


VOLUME /config /etc/cups/ /var/log/cups /var/spool/cups /var/cache/cups

EXPOSE 631
