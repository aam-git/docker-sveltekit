Docker Svelte Kit
========
powered by node:17-alpine

[SvelteKit][1] The Fastest Way to Build Svelte Apps.


Available tags you can use: 

- latest (skeleton template) DEFAULT
- production-tailwind (skeleton template with tailwind 2)
- production-demo (demo template)
- dev (skeleton template)
- dev-demo (demo template)

dev tags run in live reload mode so you can make changes to the file and they update on the website without need to restart


## docker-compose.yml

```yaml
version: '2'
services:
  sveltekit:
    image: ghcr.io/aam-git/docker-sveltekit
    restart: unless-stopped
    volumes:
      - sveltekit_data:/usr/src/app
    networks:
      - internal
    ports:
      - 3000
volumes:
  sveltekit_data:
    driver: local
```


[1]: https://kit.svelte.dev/
