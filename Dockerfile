FROM node:17-alpine

MAINTAINER AAMServices <info@aamservices.uk>

USER node

WORKDIR /usr/src/app

RUN npm init svelte@next /usr/src/app

RUN NODE_ENV=development && npm install

EXPOSE 3000

CMD ["npm", "run", "dev"]