FROM bitnami/git:latest as install

WORKDIR /install

RUN git clone https://github.com/sveltejs/kit.git

RUN mv /install/kit/packages/create-svelte/templates/skeleton/package.template.json /install/kit/packages/create-svelte/templates/skeleton/package.json && \
		sed -i 's/workspace:\*/next/g' /install/kit/packages/create-svelte/templates/skeleton/package.json && \ 
		sed -i 's/svelte-kit dev/svelte-kit dev --host 0.0.0.0/g' /install/kit/packages/create-svelte/templates/skeleton/package.json && \ 
		

FROM node:17-alpine

MAINTAINER AAMServices <info@aamservices.uk>

USER node

WORKDIR /usr/src/app

COPY --from=install --chown=node:node /install/kit/packages/create-svelte/templates/skeleton/ .

RUN NODE_ENV=development && npm install

EXPOSE 3000

CMD ["npm", "run", "dev"]