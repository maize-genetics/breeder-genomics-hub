FROM jupyter/base-notebook:lab-4.0.1
LABEL maintainer="Matt Wiese <matthew.wiese@cornell.edu>"
SHELL ["/bin/bash", "-c"]
ARG conda_env=mendel

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

# Install Conda libraries from environment.yml
COPY --chown=${NB_UID}:${NB_GID} environment.yml "/tmp/${NB_USER}/"
RUN cd "/tmp/${NB_USER}/"                                                   && \
    mamba env create -p "${CONDA_DIR}/envs/${conda_env}" -f environment.yml && \
    mamba clean --all -f -y                                                 && \
    cd && rm -r "/tmp/${NB_USER}/"

# Create Python kernel and link it to jupyter
RUN "${CONDA_DIR}/envs/${conda_env}/bin/python" -m ipykernel install --user --name='Python3' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Remove default Python kernel to avoid confusion
RUN "${CONDA_DIR}/envs/${conda_env}/bin/python" -m jupyter kernelspec remove -f python3 && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Additional pip installs
# NOTE: JupyterHub package version must match deployed Hub version
RUN "${CONDA_DIR}/envs/${conda_env}/bin/pip" install --no-cache-dir jupyterhub==4.0.1

# Install R libraries (within Conda R environment, not system R)
# Source is necessary, see: https://github.com/conda/conda/issues/7980#issuecomment-441358406
# NOTE: Still encountering weird errors when install R packages built from source - think it's caused by Conda and finding shared libraries?
ADD libraries.R libraries.R
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate "${conda_env}"            && \
    Rscript libraries.R                      && \
    rm libraries.R

# Make default environment
RUN echo "conda activate ${conda_env}" >> "${HOME}/.bashrc"