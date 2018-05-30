FROM unocha/debian-base-s6:8-slim

ENV WORKDIR=/srv/www

WORKDIR $WORKDIR

COPY . .

RUN mkdir -p /srv/www /root /var/run/s6 /etc/services.d/snap && \
    cp docker/run_snap /etc/services.d/snap/run && \
    curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub -o linux_signing_key.pub && \
    apt-key add linux_signing_key.pub && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get -qy update && \
    apt-get -qy install \
        psmisc \
        net-tools \
        libgconf-2-4 \
        imagemagick \
        ttf-freefont && \
    apt-get -qy install \
        --no-install-recommends \
        google-chrome-unstable && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /src/*.deb

EXPOSE 9222
