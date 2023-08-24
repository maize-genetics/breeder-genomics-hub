---
layout: default
title: Included Software
nav_order: 3
description: "Details on the bioinformatics software included in the Breeder Genomics Hub"
permalink: /software
---

# Included Software
The Breeder Genomics Hub uses the [breeder-notebook](https://github.com/maize-genetics/breeder-notebook) as its base environment for all users. A nonexhaustive list of bundled software is included below.

The notebook environment and its associated software is a community endeavor, so if there's something that you think should be included, please [open an issue](https://github.com/maize-genetics/breeder-notebook/issues/new/choose) on the breeder-notebook GitHub repository.

## Buckler Lab Software
Software developed by members of the [Buckler Lab](https://maizegenetics.net):
* [TASSEL](https://tassel.bitbucket.io/)
* The [Practical Haplotype Graph](https://www.maizegenetics.net/phg)
* [rTASSEL](https://rtassel.maizegenetics.net/) and [rPHG](https://rphg.maizegenetics.net/)

## Innovation Lab for Crop Improvement
Software developed by members of the [Feed the Future Innovation Lab for Crop Improvement](https://ilci.cornell.edu/):
* [BrAPI](https://brapi.org/) Helper JupyterLab extension that provides GUI for managing database connections to breeding management systems (e.g. [BMS](https://integratedbreeding.net/), [BreedBase](https://breedbase.org/), [GIGWA](https://gigwa.southgreen.fr/gigwa/))
* [Notebook templates](https://github.com/agostof/ILCI-NotebookTemplates) (using [JupyterLab Templates](https://github.com/finos/jupyterlab_templates)) providing instruction on common bioinformatics and data science pipelines for breeders

## Common Bioinformatics Tools
* [minimap2](https://github.com/lh3/minimap2)
* [samtools & bcftools](http://www.htslib.org/)
* [bwa (Burrow-Wheeler Aligner)](https://github.com/lh3/bwa)

## Programming Languages
The JupyterLab environment comes with [kernels](https://docs.jupyter.org/en/latest/projects/kernels.html) for the following:
* [Python](https://www.python.org/)
* [R](https://www.r-project.org/)
* [Kotlin](https://kotlinlang.org/)

# Installing Additional Software

{: .note }
> If users wish to install packages via [Apt](https://en.wikipedia.org/wiki/APT_(software)), which requires super-user privileges, the Docker image used by the Hub will have to be modified. One can either [open an issue](https://github.com/maize-genetics/breeder-genomics-hub/issues/new?labels=support) on the breeder-notebook repository to request the package be added, fork the breeder-notebook, or substitute their own Docker image entirely.

The [permanent storage](/getting-started#permanent-storage) can be configured to save the user's entire home directory (everything in `~/`) such that installed packages - e.g. via [Conda](https://conda.io) - persist between server restarts. Although the breeder-notebook is designed to provide researchers the proverbial kitchen sink, it is understood that oftentimes specific dependencies are required in order to reproduce papers or make use of existing/legacy code. Simply adjust the `DockerSpawner` volumes like so:
```python
c.DockerSpawner.volumes = { "breeder-{username}": "/home/jovyan" }
```

This will associate the user's entire home directory with their volume on the host, allowing for *all* files to be persisted. Filesystem usage should be monitored, of course, to prevent accidental overuse of available disk space.

Specific configuration related to modifying package install locations (e.g. where R installs packages) is outside the scope of this documentation.