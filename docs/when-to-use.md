---
layout: default
title: When to Use
nav_order: 5
description: "When to use the Breeder Genomics Hub instead of alternatives like TLJH and Z2JH"
permalink: /when-to-use
---

# When to Use the Breeder Genomics Hub
The Breeder Genomics Hub is a "distribution" or "flavor" of [JupyterHub](https://jupyter.org/hub) that bundles software useful in plant science and plant breeding research. It's designed to be easily deployed on any Linux system with Docker, for use in a research lab setting. We encourage you to try out the Breeder Genomics Hub, but understand that it may not be the right fit for every group.

If you are interested in using JupyterHub, we suggest you familiarize yourself with the ecosystem before settling on any one solution. There are two projects with large support in the Jupyter community that may satisfy your needs:
* [The Littlest JupyterHub](https://tljh.jupyter.org) (TLJH)
    * TLJH is designed for a small number of users (<100), but requires a dedicated server to be installed onto - unlike the Breeder Genomics Hub, it doesn't use Docker to spawn per-user container-based environments, as all users live on the same Linux system. If your group has "[sysadmin](https://en.wikipedia.org/wiki/System_administrator)" experience, or a dedicated IT person, this may be a good fit.
* [Zero to JupyterHub with Kubernetes](https://z2jh.jupyter.org) (Z2JH)
    * Z2JH, as the name implies, uses [Kubernetes](https://kubernetes.io/) to deploy JupyterHub. Similar to the Breeder Genomics Hub, user environments utilize containers, providing isolation and consistent tooling. However, managing a Kubernetes cluster is non-trivial, so this approach is best when your use case demands scale (i.e. many users, >100).
    * The [breeder-notebook](https://github.com/maize-genetics/breeder-notebook) that is used by the Breeder Genomics Hub can also be used with Z2JH - see the [Customizing User Environment](https://z2jh.jupyter.org/en/stable/jupyterhub/customizing/user-environment.html) page of the Z2JH documentation.
