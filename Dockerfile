FROM unocha/debian-snap-base:10-buster-node12-201907-02

ENV WORKDIR=/srv/www

WORKDIR $WORKDIR

COPY . .

RUN mkdir -p /srv/www /root /var/run/s6 /etc/services.d/snap && \
    cp docker/run_snap /etc/services.d/snap/run && \
    rm -rf /etc/services.d/node

EXPOSE 9222
