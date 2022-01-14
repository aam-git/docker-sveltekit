FROM alpine/git as preinstall

RUN git clone https://github.com/sveltejs/kit.git /install/kit && \
		sed -i 's/workspace:\*/next/g' /install/kit/packages/create-svelte/templates/default/package.json && \
		rm /install/kit/packages/create-svelte/templates/default/package.template.json && \
		sed -i 's/adapter-auto/adapter-node/g' /install/kit/packages/create-svelte/templates/default/svelte.config.js

FROM node:17-alpine as build

WORKDIR /install

COPY --from=preinstall /install/kit/packages/create-svelte/templates/default/ .

RUN NODE_ENV=development && npm install && npm i @sveltejs/adapter-node@next && npm run build
		

FROM node:17-alpine

MAINTAINER AAMServices <info@aamservices.uk>

USER node

WORKDIR /usr/src/app

COPY --from=build --chown=node:node /install/package.json /install/build/ .

RUN NODE_ENV=production && npm install

USER node

EXPOSE 3000

CMD ["node", "index.js"]