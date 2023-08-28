---
layout: default
title: Example Usage
nav_order: 4
description: "Example configs with notes on how the Buckler Lab uses the Breeder Genomics Hub"
permalink: /example
---

# Example Usage
## How the Buckler Lab uses the Breeder Genomics Hub
You may have noticed the link to [demo.hub.maizegenetics.net](https://demo.hub.maizegenetics.net) at the top of all documentation pages. This is a live playground available to the public for experimenting with the Breeder Genomics Hub, set up to mimic how our lab makes use of the Jupyter ecosystem.

This page of the documentation will walk you through how to set up the Breeder Genomics Hub exactly like the demo, utilizing PostgreSQL and PHG BrAPI containers to enable users to make queries from the Jupyter environment, via packages like [rPHG](https://rphg.maizegenetics.net) and [rTASSEL](https://rtassel.maizegenetics.net).

## Set Up
### Load Public Maize 2.1 Database Dump

{: .note }
> You will need to add a line to `prod.env` for the Postgres read-only user's password:
>
> ```
> PGPASSWORD=<Password for read_only_user>
> ```

Before running the Compose script, you must load the public maize data into Postgres. To do so, follow the steps below:
1. Ensure the most recent public maize release is stored on the mounted `/mnt/volume_nyc3_01/20230717_public_maize_2_1` volume.
2. Execute the [`load_maize.sh`](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/example/load_maize.sh) script from within the `example/` directory.
3. Wait for the above script to load the `pg_dump` files into Postgres. You can stop the container after it's finished.

Source: [Lynn's instructions](https://bucklerlab.slack.com/archives/CCJ65QR0U/p1690295272829479) on creating and loading a PHG database.

### Running
From the root of this repository:
```console
docker compose -f hub.yml -f example/example.yml up -d
```

The second `-f` will apply [`example.yml`](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/example/example.yml) as a [Compose merge](https://docs.docker.com/compose/multiple-compose-files/merge/) on top of `hub.yml`. This is a powerful feature of Docker Compose, enabling you to extend the Breeder Genomics Hub without having to modify `hub.yml` itself, providing for easy `git pull` updates.

## Extending / Developing
Chances are that the Breeder Genomics Hub doesn't satisfy all your lab's requirements. Given this reality, the project is [distributed under the MIT license](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/LICENSE) and users are encouraged to modify or extend the various configuration files in order to best meet their research objectives.

If you encounter problems while doing so, or otherwise have questions, please [open an issue with the "support" label](https://github.com/maize-genetics/breeder-genomics-hub/issues/new?labels=support) and we will do our best to help you out!

### Monitoring and Usage Metrics
JupyterHub provides [a Prometheus-compatible endpoint](https://jupyterhub.readthedocs.io/en/stable/reference/monitoring.html) at `/metrics` that can be used to monitor user activity. This is useful for gauging resource usage and user engagement, as well as for monitoring abuse.

In order to use it, a user must be granted the `read:metrics` permission, as can be seen [in the demo's config](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/example/example_config.py#L49-L53).

Then the user must [create an API token](https://jupyterhub.readthedocs.io/en/stable/howto/rest.html#create-an-api-token) from the JupyterHub web interface before issuing requests to the metrics endpoint.

### Custom Login Page
Following the [Working with Templates and UI](https://jupyterhub.readthedocs.io/en/stable/howto/templates.html) page of the JupyterHub documentation, [this line is added](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/example/example_config.py#L82) to `jupyterhub_config.py`:
```python
c.JupyterHub.template_paths = ['/etc/jupyterhub/templates/']
```

The example's Compose file also [adds a line](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/example/example.yml#L11) to mount `templates/` onto the above path:
```yml
services:
  jupyterhub:
    volumes:
      - ./example/templates:/etc/jupyterhub/templates
```

Finally, add a `login.html` file that will override the existing template, such as [the one in use on the demo](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/example/templates/login.html). You can customize any of the templates, not just the login page - consult the JupyterHub docs for more information.