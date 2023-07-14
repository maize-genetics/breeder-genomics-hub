# Breeder Genomics Hub
**🧬 Experimental / Alpha-Quality Software 🧪**
## NAPB DigitalOcean Breeder Genomics Hub Demo
### Setup / Usage
1. `git clone https://github.com/maize-genetics/breeder-genomics-hub`
2. `cd breeder-genomics-hub`
3. Create a `prod.env` file:
```
PGPASSWORD=<Maize 2.1 Password>
OAUTH_CLIENT_ID=<APP-123ABC>
OAUTH_CLIENT_SECRET=<ORCID Secret>
```
4. Edit the placeholders in the following files with the database password (value used for `PGPASSWORD` above):
    * `brapi/application.conf` → `DBPASSWORD = ${PGPASSWORD}`
    * `brapi/config.txt` → `password=$PGPASSWORD`
5. Mount a [DigitalOcean Volume](https://docs.digitalocean.com/products/volumes/details/features/) containing the Maize 2.1 data to `/mnt/volume_nyc3_01/maize_2_1_phg/data`
6. `docker compose -f digital-ocean.yml up -d`

### Building `breeder-notebook`
The `breeder-notebook` Jupyter Docker stack (using `jupyter/base-notebook`) is built from the [`breeder-notebook/`](./breeder-notebook) directory, using GitHub Actions.

During the image build process, it pulls the following files:
* https://napb2023.maizegenetics.net/files/napb_2023_bgh_demo_01.ipynb
* https://napb2023.maizegenetics.net/files/napb_2023_bgh_demo_02.ipynb
* https://napb2023.maizegenetics.net/files/napb_demo_data.tar.gz
* https://napb2023.maizegenetics.net/files/brapi_helper_installer.run
* https://napb2023.maizegenetics.net/files/templates.tar.gz

Ensure these files are present in `breeder-genomics-hub/caddy/files` wherever you run the Compose file. This is a temporary measure until these files (templates, data, etc) are publicly accessible.

### To-do
* Cache Docker image build on GitHub Actions
    * Docker layer caching will not necessarily pick up package changes (e.g. R package installs)
    * Cache Conda and R packages instead, using [`buildx`](https://github.com/docker/buildx)/[BuildKit](https://github.com/moby/buildkit)?
        * `/opt/conda/pkgs` -> downloaded Conda packages
        * R `.libPaths()` -> `/opt/conda/lib/R/library` installed R packages (downloaded packages are in random `/tmp` directory due to `destdir=NULL` default)

### Future Ideas
* PHG parse environment `$VARIABLES` in `config.txt` so that we don't have to commit passwords
* Build "releases" containing Compose file, etc using GitHub Actions and hosted on Releases - deployment would consist of downloading the archive and running some simple wrapper script e.g. `./bgh.sh`
* Hosted demo that allows ORCID login with an example PHG BrAPI server that wipes data/accounts every 24 hours (crontab?)
