HDX Snap Service
================

Installing
----------
1. Clone repo
2. npm install
3. npm run start

Usage
-----

1. Check service is running by performing GET on /ping
2. Snap a website by making a GET request on /png with the following parameters:
    1. **url** - *mandatory* - url of the website, eg. /png?url=http://google.com
    2. **fileName** - optional - resulting file name, eg. /png?url=http://google.com&fileName=google.png
    3. **selector** - optional - snap only a part of the website described by a selector, eg. to get only the google logo by targeting element with id #hplogo: /png?url=http://google.com&selector=%23hplogo 

Development
-----------
1. Clone repo
2. npm install
3. npm install -g nodemon
4. npm run develop
