FROM gfjardim/cups:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      nano


ENV CANON_DRIVER_VERSION 3.90-1
ENV CANON_DRIVER_NAME cnijfilter-mx920series-$CANON_DRIVER_VERSION-deb
ENV CANON_DRIVER_FILE $CANON_DRIVER_NAME.tar.gz
ENV CANON_DRIVER_URL http://gdlp01.c-wss.com/gds/0/0100005170/01/$CANON_DRIVER_FILE

RUN cd "/tmp" \
 && curl -LO $CANON_DRIVER_URL \
 && tar -xf $CANON_DRIVER_FILE \
 && (dpkg -i $CANON_DRIVER_NAME/packages/cnijfilter-common_3.90-1_amd64.deb 2>&1 || true) \
 && (dpkg -i $CANON_DRIVER_NAME/packages/cnijfilter-mx920series_3.90-1_amd64.deb 2>&1 || true) \
 && apt-get -yf install \
 && echo cleanimage


CMD /sbin/my_init


VOLUME /config /etc/cups/ /var/log/cups /var/spool/cups /var/cache/cups

EXPOSE 631
