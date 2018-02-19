FROM node:8-slim

ENV NODE_APP_DIR=/srv/www \
    PORT=8080 \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    S6_VERSION=v1.21.2.2

# Uncomment to skip the chromium download when installing puppeteer. If you do,
# you'll need to launch puppeteer with:
#     browser.launch({executablePath: 'google-chrome-unstable'})

WORKDIR "${NODE_APP_DIR}"
COPY . .
EXPOSE ${PORT}

RUN apt-get update && apt-get install -yq libgconf-2-4 imagemagick psmisc net-tools && \
    mkdir -p /srv/www /root /var/run/s6 && \
# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others) \
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer \
# installs, work. \
    apt-get update && apt-get install -y wget curl --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb \
    && npm install \
    && npm install puppeteer \
    # Add user so we don't need --no-sandbox. \
    && addgroup --system pptruser && adduser --system --group pptruser \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /srv/www \
    && curl -sL https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz -o /tmp/s6.tgz && \
    tar xzf /tmp/s6.tgz -C / && \
    rm -f /tmp/s6.tgz && \
    mkdir -p /etc/services.d/snap && \
    cp docker/run_snap /etc/services.d/snap/run

ENTRYPOINT ["/init"]