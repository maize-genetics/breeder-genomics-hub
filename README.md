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