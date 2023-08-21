#!/usr/bin/env bash
# Import pg_dump .gz files into container with a mounted pgdata directory
# This allows us to reuse the database state without having to load
#     the dumps each time, which is slow
# NOTE: Once the dump is loaded, you can stop the container
docker run --name load_maize_db --rm \
    --volume ../postgres-data:/var/lib/postgresql/data \
    --volume ../brapi/public_maize_2_1.sh:/docker-entrypoint-initdb.d/public_maize_2_1.sh \
    --volume /mnt/volume_nyc3_01/20230717_public_maize_2_1:/public_maize_2_1 \
    --env-file ../prod.env \
    postgres:14
