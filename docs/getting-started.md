---
layout: default
title: Getting Started
nav_order: 2
description: "Tutorial on how to begin using the Breeder Genomics Hub"
permalink: /getting-started
---

# Getting Started
## Quick Start
Start by cloning the repository:
```bash
git clone https://github.com/maize-genetics/breeder-genomics-hub
cd breeder-genomics-hub
```

Follow the [ORCID API Tutorial](https://info.orcid.org/documentation/api-tutorials/api-tutorial-get-and-authenticated-orcid-id/) to create an application via the Developer Tools submenu after clicking on your name in the top right of the page. This will allow you to utilize ORCID's OAuth provider, enabling users to sign in with their ORCID iD.

Create an [env file](https://docs.docker.com/compose/environment-variables/env-file/) named `prod.env` containing the OAuth client ID and secret generated for your ORCID application.
```env
OAUTH_CLIENT_ID=<APP-123ABC>
OAUTH_CLIENT_SECRET=<ORCID Secret>
```

Then it's as simple as using the `hub.yml` Docker Compose config to start your Breeder Genomics Hub:

```bash
docker compose -f hub.yml up -d
```

## Customization and Configuration
TODO: what and how to edit the configs