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