FROM lolhens/baseimage:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ENV HOME="/root"
ENV LC_ALL="C.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV TERM="xterm"

RUN export DEBIAN_FRONTEND="noninteractive" \
 && usermod -u 99 nobody \
 && usermod -g 100 nobody \
 && usermod -d /home nobody \
 && chown -R nobody:users /home

RUN curl -skL http://www.bchemnet.com/suldr/pool/debian/extra/su/suldr-keyring_2_all.deb -o /tmp/suldr-keyring.deb \
 && dpkg -i /tmp/suldr-keyring.deb \
 && echo "deb http://www.bchemnet.com/suldr/ debian extra" >> /etc/apt/sources.list.d/bchemnet.list \
 && apt-get update \
 && apt-get install -y \
      cups \
      cups-pdf \
      whois \
      hplip \
      suld-driver-4.01.17 \
      python-cups \
      python-pip \
      inotify-tools \
 && pip install --upgrade pip \
 && pip install cloudprint \
 && curl -skL https://raw.github.com/tjfontaine/airprint-generate/master/airprint-generate.py -o /opt/airprint-generate.py \
 && chmod +x /opt/airprint-generate.py

ADD ./files /files

RUN cd /files && find . -type f -exec cp -f --parents '{}' / \; \
 && chmod -R +x /etc/service /etc/my_init.d \
 && mv /usr/lib/cups/backend/parallel /usr/lib/cups/backend-available/ \
 && mv /usr/lib/cups/backend/serial /usr/lib/cups/backend-available/ \
 && sed -i "s|#enable-dbus.*|enable-dbus=no|g" /etc/avahi/avahi-daemon.conf


VOLUME /config /etc/cups/ /var/log/cups /var/spool/cups /var/cache/cups
EXPOSE 631
