FROM unocha/debian-snap-base:10-buster-node12

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

# Check available versions here: https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable
ARG CHROME_VERSION="90.0.4430.72-1"

RUN \
    # Configure Chrome repo and install the latest *stable* Chrome version.
    wget --no-verbose -O /tmp/chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb && \
    apt-get install -y /tmp/chrome.deb && \
    rm /tmp/chrome.deb && \
    # Ok, cleanup!
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    mkdir -p /srv/www /root /var/run/s6 /etc/services.d/snap && \
    cp docker/run_snap /etc/services.d/snap/run && \
    rm -rf /etc/services.d/node

EXPOSE 9222