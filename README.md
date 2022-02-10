# Geniac-demo-dsl2 pipeline 

[![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A519.10.0-brightgreen.svg)](https://www.nextflow.io/)
[![Install with](https://anaconda.org/anaconda/conda-build/badges/installer/conda.svg)](https://conda.anaconda.org/anaconda)
[![Singularity Container available](https://img.shields.io/badge/singularity-available-7E4C74.svg)](https://singularity.lbl.gov/)
[![Docker Container available](https://img.shields.io/badge/docker-available-003399.svg)](https://www.docker.com/)

* [Introduction](#introduction)
* [Quick start](#quick-start)
* [Geniac documentation and useful resources](#geniac-documentation-and-useful-resources)
* [Pipeline documentation](#pipeline-documentation)
* [Acknowledgements](#acknowledgements)
* [Release notes](CHANGELOG)
* [Citation](#citation)

## Introduction

This is a demo pipeline with the best practises for the development of bioinformatics analysis pipelines with [Nextflow](https://www.nextflow.io) DSL2 and [geniac](https://github.com/bioinfo-pf-curie/geniac) (**A**utomatic **C**onfiguration **GEN**erator and **I**nstaller for nextflow pipelines). It runs within ~20 seconds a very simple bioinformatics pipeline inspired from the analysis of high-throuphput-sequencing data. The best practises proposed by [geniac](https://github.com/bioinfo-pf-curie/geniac) can be applied to any analysis workflow in data science.

This pipeline illustrates how [geniac](https://github.com/bioinfo-pf-curie/geniac) can automatically build:
* [Nextflow profiles](docs/profiles.md) configuration files
* [Singularity](https://sylabs.io/) / [Docker](https://www.docker.com/) recipes and containers
* Run the pipeline with the different [Nextflow profiles](docs/profiles.md)

## Quick start

### Prerequisites

* git (>= 2.0) [required]
* cmake (>= 3.0) [required]
* Nextflow (>= 21.10.6) [required]
* Singularity (>= 3.8.5) [optional]
* Docker (>= 18.0) [optional]

Install [conda](https://docs.conda.io):
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

### Install the geniac conda environment

```bash
# Create the geniac conda environment
export GENIAC_CONDA="https://raw.githubusercontent.com/bioinfo-pf-curie/geniac/release/environment.yml"
wget ${GENIAC_CONDA}
conda env create -f environment.yml
conda activate geniac
```

### Check the code, install and run the pipeline with the multiconda profile

```bash
export WORK_DIR="${HOME}/tmp/myPipeline"
export INSTALL_DIR="${WORK_DIR}/install"
export GIT_URL="https://github.com/bioinfo-pf-curie/geniac-demo-dsl2.git"

# Initialization of a working directory
# with the src and build folders
geniac init -w ${WORK_DIR} ${GIT_URL}
cd ${WORK_DIR}

# Check the code
geniac lint

# Install the pipeline
geniac install . ${INSTALL_DIR}

# Test the pipeline with the multiconda profile
geniac test multiconda
```

### Check the code, install and run the pipeline with the singularity profile

Note that you need `sudo` privilege to build the singularity images.

```bash
export WORK_DIR="${HOME}/tmp/myPipeline"
export INSTALL_DIR="${WORK_DIR}/install"
export GIT_URL="https://github.com/bioinfo-pf-curie/geniac-demo-dsl2.git"

# Initialization of a working directory
# with the src and build folders
geniac init -w ${WORK_DIR} ${GIT_URL}
cd ${WORK_DIR}

# Install the pipeline with the singularity images
geniac install . ${INSTALL_DIR} -m singularity
sudo chown -R  $(id -gn):$(id -gn) build

# Test the pipeline with the singularity profile
geniac test singularity

# Test the pipeline with the singularity and cluster profiles
geniac test singularity --check-cluster
```

### Advanced users

Note that the geniac command line interface provides a wrapper to `git`, `cmake` and `make` commands. Advanced users familiar with these commands can run the following (see [geniac documentation](https://geniac.readthedocs.io) for more details):

```bash
export WORK_DIR="${HOME}/tmp/myPipeline"
export SRC_DIR="${WORK_DIR}/src"
export INSTALL_DIR="${WORK_DIR}/install"
export BUILD_DIR="${WORK_DIR}/build"
export GIT_URL="https://github.com/bioinfo-pf-curie/geniac-demo.git"

mkdir -p ${INSTALL_DIR} ${BUILD_DIR}

# clone the repository
# the option --recursive is needed if you use geniac as a submodule
git clone --recursive ${GIT_URL} ${SRC_DIR}

cd ${BUILD_DIR}

# configure the pipeline
cmake ${SRC_DIR}/geniac -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}

# build the files needed by the pipeline
make

# install the pipeline
make install

# run the pipeline
make test_multiconda
```

## Pipeline documentation

The geniac-demo pipeline is a very simple bioinformatics pipeline inspired from the analysis of high-throuphput-sequencing data. More information are available here:

1. [Running the pipeline](docs/usage.md)
2. [Nextflow profiles](docs/profiles.md)
3. [Outputs](docs/output.md)

## Geniac documentation and useful resources

* The [geniac documentation](https://geniac.readthedocs.io) provides a set of best practises to implement *Nextflow* pipelines.
* The [geniac](https://github.com/bioinfo-pf-curie/geniac) source code provides the set of utilities.
* The [geniac demo](https://github.com/bioinfo-pf-curie/geniac-demo) provides a toy pipeline to test and practise *Geniac*.
* The [geniac demo DSL2](https://github.com/bioinfo-pf-curie/geniac-demo-dsl2) provides a toy pipeline to test and practise *Geniac*.
* The [geniac template](https://github.com/bioinfo-pf-curie/geniac-template) provides a pipeline template to start a new pipeline.

## Acknowledgements

* [Institut Curie](https://www.curie.fr)
* [Centre national de la recherche scientifique](http://www.cnrs.fr)
* This project has received funding from the European Union’s Horizon 2020 research and innovation programme and the Canadian Institutes of Health Research under the grant agreement No 825835 in the framework on the [European-Canadian Cancer Network](https://eucancan.com/).

## Citation

[Allain F, Roméjon J, La Rosa P et al. Geniac: Automatic Configuration GENerator and Installer for nextflow pipelines. Open Research Europe 2021, 1:76](https://open-research-europe.ec.europa.eu/articles/1-76).
