FROM jupyterhub/jupyterhub:4.0.1

RUN apt-get update  --yes &&                      \
    apt-get install --yes --no-install-recommends \
    git                                           \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir \
    dockerspawner                         \
    python-dotenv

# Install OAuthenticator ORCID fork
RUN cd /tmp && git clone https://github.com/matthewwiese/oauthenticator.git && cd oauthenticator && python3 -m pip install -e .

CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
