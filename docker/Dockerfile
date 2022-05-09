FROM public.ecr.aws/unocha/tools-snap-service:v3.0.1

ENV WORKDIR=/srv/www

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="HPC" \
      org.label-schema.version=$VERSION \
      org.label-schema.name="hpc-headless-chrome" \
      org.label-schema.description="This service provides a headless-chrome for FTS" \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

WORKDIR $WORKDIR

COPY ./docker/run_snap /tmp/run

# Check available versions here: https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable
ARG CHROME_VERSION="101.0.4951.54-1"

RUN \
    # Fetch the specified Chrome version and install it.
    wget --no-verbose -O /tmp/chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb && \
    apt-get install -y /tmp/chrome.deb && \
    # Do not start a node process.
    rm -rf /etc/services.d/node && \
    # Remove the snap service. Bye!
    rm -rf /srv/www && \
    # Pop in our own start scripts. \
    mkdir -p /srv/www /root /var/run/s6 /etc/services.d/snap && \
    mv /tmp/run /etc/services.d/snap/run && \
    # Ok, cleanup!
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

EXPOSE 9222
