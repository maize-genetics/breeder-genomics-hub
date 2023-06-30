# Breeder Genomics Hub
**🧬 Experimental / Alpha Quality Software 🧪**
## NAPB DigitalOcean Breeder Genomics Hub Demo
### Setup
Create a `prod.env` file like the contents:
```
POSTGRES_PASSWORD=<Maize 2.1 Password>
```

Postgres will check the `POSTGRES_PASSWORD` by default in `prod.env`. We can do the same for the PHG BrAPI server.

Additionally, mount a [DigitalOcean Volume](https://docs.digitalocean.com/products/volumes/details/features/) containing the Maize 2.1 data to:
```
/mnt/volume_nyc3_01/maize_2_1_phg/data
```

### Running
```
docker compose -f digital-ocean.yml up -d
```

### To-do
* PHG parse environment `$VARIABLES` in `config.txt` so that we don't have to commit passwords
* Add Traefik (and JupyterHub) container, proxying as following:
    * `napb2023.maizegenetics.net:<443,80>` -> JupyterHub (plus R, packages, and BrAPI helper)
    * `napb2023.maizegenetics.net:8080` -> PHG BrAPI Server
    * *Postgres is not available on an external port*
* Extend JupyterHub container to install:
    * R and R packages
    * BrAPI Helper
    * JupyterHub-specific packages
        * Docker spawner: `python3 -m pip install dockerspawner`
        * ORCID Authenticator fork (`OrcidOAuthenticator`): https://github.com/matthewwiese/oauthenticator

# Future Ideas
* Build "releases" containing Compose file, etc using GitHub Actions and hosted on Releases - deployment would consistent of downloading the archive and running some simple wrapper script e.g. `./bgh.sh`
* Hosted demo that allows ORCID login with an example PHG BrAPI server that wipes data/accounts every 24 hours (crontab?)
