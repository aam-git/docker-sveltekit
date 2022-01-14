FROM bitnami/git:latest as install

WORKDIR /install

RUN git clone https://github.com/sveltejs/kit.git

RUN sed -i 's/workspace:\*/next/g' /install/kit/packages/create-svelte/templates/default/package.json && rm /install/kit/packages/create-svelte/templates/default/package.template.json

FROM node:17-alpine

MAINTAINER AAMServices <info@aamservices.uk>

WORKDIR /usr/src/app

COPY --from=install /install/kit/packages/create-svelte/templates/default/ .

RUN NODE_ENV=development && npm install

USER node

EXPOSE 3000

CMD ["npm", "run", "dev"]