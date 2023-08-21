import os
from dotenv import load_dotenv
from dockerspawner import DockerSpawner
from oauthenticator.generic import GenericOAuthenticator

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

c.JupyterHub.authenticator_class = GenericOAuthenticator
c.GenericOAuthenticator.oauth_callback_url = f"https://{os.environ.get('HUB_DOMAIN')}/hub/oauth_callback"
c.GenericOAuthenticator.client_id = os.environ.get("OAUTH_CLIENT_ID")
c.GenericOAuthenticator.client_secret = os.environ.get("OAUTH_CLIENT_SECRET")
c.GenericOAuthenticator.login_service = "ORCID iD"
c.GenericOAuthenticator.authorize_url = "https://orcid.org/oauth/authorize"
c.GenericOAuthenticator.token_url = "https://orcid.org/oauth/token"
c.GenericOAuthenticator.scope = ["/authenticate", "openid"]
c.GenericOAuthenticator.userdata_url = "https://orcid.org/oauth/userinfo"
c.GenericOAuthenticator.username_claim = "sub"
c.GenericOAuthenticator.allow_all = True # Allow any ORCID iD for the demo
