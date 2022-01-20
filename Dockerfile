FROM alpine/git as preinstall

RUN git clone https://github.com/sveltejs/kit.git /install/kit && \
		mv /install/kit/packages/create-svelte/templates/skeleton/package.template.json /install/kit/packages/create-svelte/templates/skeleton/package.json && \
		sed -i 's/workspace:\*/next/g' /install/kit/packages/create-svelte/templates/skeleton/package.json && \ 
		sed -i 's/adapter-auto/adapter-node/g' /install/kit/packages/create-svelte/templates/skeleton/package.json && \ 
		sed -i 's/adapter-auto/adapter-node/g' /install/kit/packages/create-svelte/templates/skeleton/svelte.config.js

FROM node:17-alpine as build

WORKDIR /install

COPY --from=preinstall /install/kit/packages/create-svelte/templates/skeleton/ .

RUN NODE_ENV=development && npm install && npm i @sveltejs/adapter-node@next svelte-preprocess postcss autoprefixer tailwindcss && npx svelte-add@latest tailwindcss && npm run build
		

FROM node:17-alpine

MAINTAINER AAMServices <info@aamservices.uk>

USER node

WORKDIR /usr/src/app

COPY --from=build --chown=node:node /install/package.json /install/build/ .

RUN NODE_ENV=production && npm install

USER node

EXPOSE 3000

CMD ["node", "index.js"]