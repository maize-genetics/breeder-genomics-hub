FROM jupyter/base-notebook:lab-4.0.1
LABEL maintainer="Matt Wiese <matthew.wiese@cornell.edu>"
SHELL ["/bin/bash", "-c"]

# Install apt packages - for R packages built from source
USER root
RUN apt-get update  --yes &&                      \
    apt-get install --yes --no-install-recommends \
    build-essential                               \
    gfortran                                      \
    gcc                                           \
    libfontconfig1-dev                            \
    libfreetype6-dev                              \
    fonts-dejavu                                  \
    libfribidi-dev                                \
    libharfbuzz-dev                               \
    unixodbc                                      \
    unixodbc-dev                                  \
    make                                          \
    pandoc                                        \
    libicu-dev                                    \
    libjpeg-dev                                   \
    libpng-dev                                    \
    libtiff-dev                                   \
    zlib1g-dev                                    \
    libssl-dev                                    \
    libxml2-dev                                   \
    libcurl4-openssl-dev                          \
    libcairo2-dev                                 \
    libxt-dev                                     \
    libgeos-dev                                   \
    libudunits2-dev                               \
    libgdal-dev                                   \
    gdal-bin                                      \
    libproj-dev                                   \
    libsqlite3-dev                                \
    libudunits2-dev                               \
    && rm -rf /var/lib/apt/lists/*
USER ${NB_UID}

# Install Conda libraries from environment.yml into base environment
ADD environment.yml /tmp/environment.yml
RUN mamba env update --name base --file /tmp/environment.yml

# Additional pip installs
# NOTE: JupyterHub package version must match deployed Hub version
RUN pip install --no-cache-dir jupyterhub==4.0.1

# Install R libraries
ADD libraries.R /tmp/libraries.R
RUN Rscript /tmp/libraries.R
