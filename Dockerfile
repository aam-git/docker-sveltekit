FROM alpine/git as install

WORKDIR /install

RUN git clone https://github.com/sveltejs/kit.git

RUN sed -i 's/workspace:\*/next/g' /install/kit/packages/create-svelte/templates/default/package.json && \ 
		sed -i 's/svelte-kit dev/svelte-kit dev --host 0.0.0.0/g' /install/kit/packages/create-svelte/templates/default/package.json && \ 
		rm /install/kit/packages/create-svelte/templates/default/package.template.json

FROM node:17-alpine

MAINTAINER AAMServices <info@aamservices.uk>

USER node

WORKDIR /usr/src/app

COPY --from=install --chown=node:node /install/kit/packages/create-svelte/templates/default/ .

RUN NODE_ENV=development && npm install

EXPOSE 3000

CMD ["npm", "run", "dev"]
