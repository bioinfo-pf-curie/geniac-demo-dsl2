# Nextflow profiles


If `-profile` is not specified at all the pipeline will be run locally and expects all software to be installed and available in the `PATH` environment variable. The following `-profile` are available:

## Define where the tools are available


###  `conda`

Build a new conda environment before running the pipeline.
The conda environment will be created in the `$HOME/conda-cache-nextflow` folder by default.  Use the option `--condaCacheDir` to change the default conda cache directory.

###  `multiconda`

Build new conda environments for each process before running the pipeline.
The conda environments will be created in the `$HOME/conda-cache-nextflow` folder by default.  Use the option `--condaCacheDir` to change the default conda cache directory.

###  `path`

By default, Nextflow expects all the tools to be installed and available in the `PATH` environment variable.
This path can be set using the `-profile path` combined with the `--globalPath /my/path` option specifying where the tools are installed.
Assume that the pipeline has been installed in `${HOME}/tmp/myPipeline/install`, geniac creates `${HOME}/tmp/myPipeline/install/path/bin` folder. If you do not defined the `--globalPath` option, the `-profile path` option expect to find the tools in `${HOME}/tmp/myPipeline/install/path/bin` folder.


###  `multipath`

In addition, the `-profile multipath` is available in order to specify the `PATH` for each tool, instead of a global one.
Assume that the pipeline has been installed in `${HOME}/tmp/myPipeline/install`, geniac creates `${HOME}/tmp/myPipeline/install/multipath` folder whick look like this:

```
multipath/
├── alpine
│   └── bin
├── fastqc
│   └── bin
├── helloWorld
│   └── bin
├── multiqc
│   └── bin
├── python
│   └── bin
└── trickySoftware
    └── bin
```

The second level in the folder tree is the label that has been given in each Nextflow process. Install each tool in its corresponding `bin` directory.


###  `docker`

Use the Docker images for each process.

###  `singularity`

Use the Singularity images for each process. Use the option `--singularityImagePath` to specify where the images are available.
Assume that the pipeline has been installed in `${HOME}/tmp/myPipeline/install`, geniac creates `${HOME}/tmp/myPipeline/install/containers/singularity` folder. If you ask geniac to build the singularity images, they will be stored in this folder. If you do not defined the `--singularityImagePath` option, the `-profile singularity` option expects to find the singularity images the `${HOME}/tmp/myPipeline/install/containers/singularity` folder.

## Define where to launch the computation

By default, the pipline runs locally. If you want to run it on a computing cluster, use the profile below.

###  `cluster`

Run the workflow on the cluster, instead of locally.

## Test the pipeline

### `test`

Set up the test dataset
