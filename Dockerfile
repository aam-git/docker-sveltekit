FROM bitnami/git:latest as install

MAINTAINER AAMServices <info@aamservices.uk>

WORKDIR /install

RUN git clone https://github.com/sveltejs/kit.git

FROM node:17-alpine

MAINTAINER AAMServices <info@aamservices.uk>

COPY --from=install /install/kit/packages/create-svelte/templates/default/ .

WORKDIR /usr/src/app

RUN NODE_ENV=development && npm install

USER node

EXPOSE 3000

CMD ["npm", "run", "dev"]