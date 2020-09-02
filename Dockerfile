FROM unocha/debian-snap-base:10-buster-chrome81-node12-202001-01

ENV WORKDIR=/srv/www

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="HPC" \
      org.label-schema.version=$VERSION \
      org.label-schema.name="hpc-headless_chrome" \
      org.label-schema.description="This service provides a headless-chrome " \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

WORKDIR $WORKDIR

COPY . .

RUN \
    # Configure Chrome repo and install the latest *stable* Chrome version.
    curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub -o linux_signing_key.pub && \
    apt-key add linux_signing_key.pub && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    # Install Chrome, so it can match
    apt-get update && \
    apt-get -qy install --no-install-recommends google-chrome-stable google-chrome-unstable- && \
    apt-get -qy dist-upgrade && \
    # Ok, cleanup!
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    mkdir -p /srv/www /root /var/run/s6 /etc/services.d/snap && \
    cp docker/run_snap /etc/services.d/snap/run && \
    rm -rf /etc/services.d/node

EXPOSE 9222
