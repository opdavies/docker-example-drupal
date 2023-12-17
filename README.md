# docker-example-drupal

## Usage

* Run `cp .env.example .env`, otherwise you'll get a `no service selected` error.
* Run `docker compose up` to start the project.

Alternatively, run `./run start` to run both steps.

* Run `docker compose ps` to see the running services.
  * There should be services for `database`, `php` and `web`.

## Viewing the site

### With a Traefik proxy

The project is pre-configured to work with a Traefik proxy (I have <https://github.com/OliverDaviesLtd/traefik-development> permanently running).

If this is running, you can view the website at <http://docker-example-drupal.localhost>.

### Without a Traefix proxy

If you don't have a proxy running, you need to expose a port to connect to the web server.

Create a `docker-compose.override.yaml` file with these contents:

```yaml
services:
  web:
    ports:
      - "8000:80"
```

Run `docker compose up` again and access the site at `http://localhost:8000`.
