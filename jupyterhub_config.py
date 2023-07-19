import os
from dotenv import load_dotenv
from dockerspawner import DockerSpawner
from oauthenticator.orcid import OrcidOAuthenticator

load_dotenv("prod.env")
c = get_config()  # noqa

c.JupyterHub.spawner_class = DockerSpawner
c.DockerSpawner.image = "maizegenetics/breeder-notebook:latest"

c.Spawner.default_url = '/lab'
c.Spawner.mem_limit = "1.5G"

c.DockerSpawner.cmd = "start-singleuser.sh"
c.DockerSpawner.remove = True
c.DockerSpawner.debug = True

c.DockerSpawner.prefix = "breeder"
c.DockerSpawner.name_template = "{prefix}-{raw_username}"

# The following is important for the spawned containers to reach JupyterHub via Docker's DNS
c.DockerSpawner.hub_connect_url = "http://jupyterhub:8000"
c.DockerSpawner.use_internal_ip = True
c.DockerSpawner.network_name = "hub_net"

c.JupyterHub.port = 8000
c.JupyterHub.ip = "jupyterhub"
c.JupyterHub.hub_ip = "jupyterhub"

c.JupyterHub.authenticator_class = OrcidOAuthenticator
c.OrcidOAuthenticator.oauth_callback_url = "https://napb2023.maizegenetics.net/hub/oauth_callback"
c.OrcidOAuthenticator.client_id = os.environ.get("OAUTH_CLIENT_ID")
c.OrcidOAuthenticator.client_secret = os.environ.get("OAUTH_CLIENT_SECRET")
c.OrcidOAuthenticator.allow_all = True # Allow any ORCID iD for the workshop
