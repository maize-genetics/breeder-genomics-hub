# Breeder Genomics Hub
**🧬 Experimental / Alpha Quality Software 🧪**
## NAPB DigitalOcean Breeder Genomics Hub Demo
### Setup
Create a `prod.env` file like the contents:
```
PGPASSWORD=<Maize 2.1 Password>
```

Postgres will check the `PGPASSWORD` by default in `prod.env`. We can do the same for the PHG BrAPI server.

Additionally, mount a [DigitalOcean Volume](https://docs.digitalocean.com/products/volumes/details/features/) containing the Maize 2.1 data to:
```
/mnt/volume_nyc3_01/maize_2_1_phg/data
```

### Running
```
docker compose -f digital-ocean.yml up -d
```

### To-do
/opt/conda/lib/R/library
* Cache Docker image build on GitHub Actions
    * Docker layer caching will not necessarily pick up package changes (e.g. R package installs)
    * Cache Conda and R packages instead, using [`buildx`](https://github.com/docker/buildx)/[BuildKit](https://github.com/moby/buildkit)?
        * `/opt/conda/pkgs` -> downloaded Conda packages
        * R `.libPaths()` -> `/opt/conda/lib/R/library` installed R packages (downloaded packages are in random `/tmp` directory due to `destdir=NULL` default)
* Use JupyterLab 3.x due to compatibility issue with JupyterLab Templates and BrAPI Helper

### Future Ideas
* PHG parse environment `$VARIABLES` in `config.txt` so that we don't have to commit passwords
* Build "releases" containing Compose file, etc using GitHub Actions and hosted on Releases - deployment would consist of downloading the archive and running some simple wrapper script e.g. `./bgh.sh`
* Hosted demo that allows ORCID login with an example PHG BrAPI server that wipes data/accounts every 24 hours (crontab?)
