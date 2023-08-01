FROM jupyterhub/jupyterhub:4.0.1

RUN apt-get update  --yes &&                      \
    apt-get install --yes --no-install-recommends \
    git                                           \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir \
    dockerspawner                         \
    oauthenticator                        \
    python-dotenv

CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
