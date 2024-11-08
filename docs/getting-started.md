---
layout: default
title: Getting Started
nav_order: 2
description: "Tutorial on how to begin using the Breeder Genomics Hub"
permalink: /getting-started
---

# Getting Started

{: .note }
> If you have questions about using or deploying your own Breeder Genomics Hub, [create a GitHub issue with the "support" label](https://github.com/maize-genetics/breeder-genomics-hub/issues/new?labels=support)!

## Quick Start
Clone the repository:
```bash
git clone https://github.com/maize-genetics/breeder-genomics-hub
cd breeder-genomics-hub
```

Follow the [ORCID API Tutorial](https://info.orcid.org/documentation/api-tutorials/api-tutorial-get-and-authenticated-orcid-id/) to create an application via the Developer Tools submenu after clicking on your name in the top right of the page. This will allow you to utilize ORCID's OAuth provider, enabling users to sign in with their ORCID iD.

Create an [env file](https://docs.docker.com/compose/environment-variables/env-file/) named `prod.env` containing the OAuth client ID and secret generated for your ORCID application.

Additionally, add the `HUB_DOMAIN` environment variable with the domain that you'll be using to access the Breeder Genomics Hub. This is used by the reverse proxy [Caddy](https://caddyserver.com/) to acquire a TLS certificate automatically via [Let's Encrypt](https://letsencrypt.org/). If you wish to force HTTP and not use a certificate, prefix this value with `http://` (e.g. `http://0.0.0.0:80`).
```
OAUTH_CLIENT_ID=<APP-123ABC>
OAUTH_CLIENT_SECRET=<ORCID Secret>
HUB_DOMAIN=myhub.example.com
UID=1000
```

The `UID` value above is interpolated within the `hub.yml` Docker Compose config to utilize the Docker socket associated with your user. You can append this line easily by running:

```bash
echo "UID=$UID" >> prod.env
```

Then it's as simple as using `hub.yml` to start your Breeder Genomics Hub:

```bash
docker compose --env-file prod.env -f hub.yml up -d
```

Make sure to include the `--env-file prod.env` option so that the `UID` value is recognized by Docker Compose.

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

#### **User-installed Packages (Python, R, etc)**
Please see the [Installing Additional Software](/software#installing-additional-software) section.

### User Authentication and Authorization
In JupyterHub, [Authenticators](https://jupyterhub.readthedocs.io/en/stable/reference/authenticators.html) are responsible for managing both authentication (verifying a user is who they say they are) and authorization (verifying if a given user is allowed to do some action). By default, the Breeder Genomics Hub uses ORCID's [OAuth](https://en.wikipedia.org/wiki/OAuth) functionality to enable individuals to log in to a Hub with their existing ORCID iD, removing the need for them to create an account specific to the Hub. For more information on using ORCID for logins, see the below subsection [About ORCID iD & OAuth](#about-orcid-id--oauth).

The general topic of authentication and authorization has security implications, and is therefore outside the scope of this documentation. A good starting point for JupyterHub specifically is their [Authentication and User Basics](https://jupyterhub.readthedocs.io/en/stable/tutorial/getting-started/authenticators-users-basics.html) tutorial page.

For example, if you'd like to limit access to an instance of the Breeder Genomics Hub, simply add the following to your `jupyterhub_config.py`:
```python
c.GenericOAuthenticator.allowed_users = { "0000-0002-9079-593X", "0000-0002-3100-371X" }
```

The above would limit access to [Stephen Hawking](https://orcid.org/0000-0002-9079-593X) and [Ed Buckler](https://orcid.org/0000-0002-3100-371X).

#### **About ORCID iD & OAuth**
The configuration for `GenericOAuthenticator` as seen [in the code](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/jupyterhub_config.py#L32-L40), follows the procedure in the [Setup for ORCID iD](https://oauthenticator.readthedocs.io/en/latest/tutorials/provider-specific-setup/providers/generic.html#setup-for-orcid-id) section of the `GenericOAuthenticator` docs.

There are a variety of additional config options available; consult the [`GenericOAuthenticator` API Reference](https://oauthenticator.readthedocs.io/en/latest/reference/api/gen/oauthenticator.generic.html) for more information.

For example, this config allows [any authenticated ORCID iD holder](https://github.com/maize-genetics/breeder-genomics-hub/blob/main/example/example_config.py#L44) to log in.

### Redirect URI
By default the redirect URI used by `GenericOAuthenticator` is based on the `HUB_DOMAIN` environment variable specified in the `prod.env` file.

If you wish to use a different redirect URI, provide a `REDIRECT_URI` value in your `prod.env` file:
```
REDIRECT_URI=https://thirdparty.com/oauth/callback1
```

Please refer to [this](https://info.orcid.org/ufaqs/how-do-redirect-uris-work/) ORCID FAQ for more information about how redirect URIs work.
