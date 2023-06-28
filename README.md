# Breeder Genomics Hub
**🧬 Experimental / Alpha Quality Software 🧪**
## NAPB DigitalOcean Breeder Genomics Hub Demo
### Setup
Create a `prod.env` file like the contents:
```
POSTGRES_PASSWORD=<Maize 2.1 Password>
```

The Postgres will check the `POSTGRES_PASSWORD` by default in `prod.env`. We can do the same for the PHG BrAPI server.

### Running
```
docker compose -f digital-ocean.yml up -d
```
