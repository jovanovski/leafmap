FROM jupyter/scipy-notebook:latest
RUN mamba install -c conda-forge leafmap geopandas localtileserver osmnx -y && \
    pip install -U leafmap jsonschema==4.18.0 && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN mkdir ./examples
COPY /examples/notebooks ./examples/notebooks
COPY /examples/workshops ./examples/workshops
COPY /examples/data ./examples/data
COPY /examples/README.md ./examples/README.md

ENV PROJ_LIB='/opt/conda/share/proj'

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}