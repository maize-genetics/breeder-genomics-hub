import os
from dockerspawner import DockerSpawner

c = get_config()  # noqa

c.JupyterHub.spawner_class = DockerSpawner
c.DockerSpawner.image = "maizegenetics/breeder-notebook:latest"

c.Spawner.default_url = '/lab'
c.Spawner.mem_limit = "1G"

c.DockerSpawner.cmd = "start-singleuser.sh"

c.DockerSpawner.remove = True

c.DockerSpawner.debug = True

# The following is important for the spawned containers to reach JupyterHub via Docker's DNS
c.DockerSpawner.hub_connect_url = "http://jupyterhub:8000"
c.DockerSpawner.use_internal_ip = True
c.DockerSpawner.network_name = "hub_net"

c.JupyterHub.port = 8000
c.JupyterHub.ip = "jupyterhub"
c.JupyterHub.hub_ip = "jupyterhub"

# TODO: Replace with OAuthenticator fork with ORCID support
c.JupyterHub.authenticator_class = "dummy"
c.DummyAuthenticator.password = os.environ.get("DUMMY")
c.Authenticator.admin_users = ["corncob"]
