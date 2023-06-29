FROM jupyter/datascience-notebook:lab-4.0.1

ARG conda_env=science

# Install Conda libraries from environment.yml
COPY --chown=${NB_UID}:${NB_GID} environment.yml "/home/${NB_USER}/tmp/"
RUN cd "/home/${NB_USER}/tmp/" && \
    mamba env create -p "${CONDA_DIR}/envs/${conda_env}" -f environment.yml && \
    mamba clean --all -f -y

# Create Python kernel and link it to jupyter
RUN "${CONDA_DIR}/envs/${conda_env}/bin/python" -m ipykernel install --user --name="${conda_env}" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Additional pip installs
RUN "${CONDA_DIR}/envs/${conda_env}/bin/pip" install --no-cache-dir jupyterhub==1.4.1

# Install R libraries
ADD libraries.R libraries.R
RUN Rscript libraries.R

# Make default environment
RUN echo "conda activate ${conda_env}" >> "${HOME}/.bashrc"