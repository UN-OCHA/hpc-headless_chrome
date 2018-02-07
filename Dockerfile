FROM unocha/nodejs:8.9.4

WORKDIR /srv/www

COPY . .

RUN npm install