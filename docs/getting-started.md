---
layout: default
title: Getting Started
nav_order: 2
description: "Tutorial on how to begin using the Breeder Genomics Hub"
permalink: /getting-started
---

# Getting Started
## Quick Start
Clone the repository:
```bash
git clone https://github.com/maize-genetics/breeder-genomics-hub
cd breeder-genomics-hub
```

Follow the [ORCID API Tutorial](https://info.orcid.org/documentation/api-tutorials/api-tutorial-get-and-authenticated-orcid-id/) to create an application via the Developer Tools submenu after clicking on your name in the top right of the page. This will allow you to utilize ORCID's OAuth provider, enabling users to sign in with their ORCID iD.

Create an [env file](https://docs.docker.com/compose/environment-variables/env-file/) named `prod.env` containing the OAuth client ID and secret generated for your ORCID application.

Additionally, add the `HUB_DOMAIN` environment variable with the domain that you'll be using to access the Breeder Genomics Hub. This is used by the reverse proxy [Caddy](https://caddyserver.com/) to acquire a TLS certificate automatically via [Let's Encrypt](https://letsencrypt.org/).
```
OAUTH_CLIENT_ID=<APP-123ABC>
OAUTH_CLIENT_SECRET=<ORCID Secret>
HUB_DOMAIN=myhub.example.com
```

Then it's as simple as using the `hub.yml` Docker Compose config to start your Breeder Genomics Hub:

```bash
docker compose -f hub.yml up -d
```

## Customization and Configuration
### Permanent Storage
The Breeder Genomics Hub uses [DockerSpawner](https://github.com/jupyterhub/dockerspawner) to start containers for each user. The files within the container are only available during the lifecycle of the container (i.e. are deleted when it is stopped). In order to provide a means for users to store persistent data, we must configure the extension to mount a volume from the host into the spawned container. This volume will persist on the host filesystem between container restarts, enabling users to save data into the `~/work` directory that they don't want to lose. Add the following to your `jupyterhub_config.py`:
```python
notebook_dir = "/home/jovyan/work"
c.DockerSpawner.notebook_dir = notebook_dir
c.DockerSpawner.volumes = { "breeder-{username}": notebook_dir }
```

#### **Choose Where Data Is Stored**
The above config snippet will create a Docker volume with a default mount point. If you are on Linux, it will likely be stored at `~/.local/share/docker/volumes`. Using bind mounts via an absolute path is currently broken ([#453](https://github.com/jupyterhub/dockerspawner/issues/453)), so if an administrator wishes to store persistent data elsewhere, they will need to employ a [symbolic link](https://en.wikipedia.org/wiki/Symbolic_link):

```console
ln -s /tmp/hub_userdata /home/your_user/.local/share/docker/volumes
```

You can list all current volumes via `docker volume ls`, and view information about any of them using `docker inspect`. For example, for a volume named `breeder-bob`:

```console
your_user@your_server:~$ docker inspect breeder-bob
[
    {
        "CreatedAt": "2023-01-01T00:00:00Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/home/your_user/.local/share/docker/volumes/breeder-bob/_data",
        "Name": "breeder-bob",
        "Options": null,
        "Scope": "local"
    }
]
```

For further context, see [this GitHub comment](https://github.com/jupyterhub/dockerspawner/issues/453#issuecomment-1665871467).