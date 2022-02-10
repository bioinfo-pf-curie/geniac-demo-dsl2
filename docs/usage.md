# Usage

## Table of contents

* [Quick help](#quick-help)
* [Quick run](#quick-run)
* [Running the pipeline](#running-the-pipeline)
* [Main arguments](#main-arguments)
    * [`-profile`](#-profile)
    * [`--reads`](#-reads)
    * [`--samplePlan`](#-sampleplan)
	* [`--design`](#--design) 
* [Inputs](#inputs)
    * [`--singleEnd`](#--singleend)
* [Nextflow profiles](#nextflow-profiles)
* [Job resources](#job-resources)
* [Other command line parameters](#other-command-line-parameters)
    * [`--skip*`](#-skip)
    * [`--metadata`](#-metadata)
    * [`--outDir`](#-outDir)
    * [`-name`](#-name)
    * [`-resume`](#-resume)
    * [`-c`](#-c)
    * [`--maxMemory`](#-maxmemory)
    * [`--maxTime`](#-maxtime)
    * [`--maxCpus`](#-maxcpus)
    * [`--multiqcConfig`](#-multiqcconfig)


## Quick help

```bash
nextflow run main.nf --help
N E X T F L O W  ~  version 21.04.3
Launching `main.nf` [romantic_shockley] - revision: 01e24e3839

@git_repo_name@ version: @git_commit@
======================================================================

Usage:
nextflow run main.nf --reads '*_R{1,2}.fastq.gz' --genome 'hg19' -profile conda
nextflow run main.nf --samplePlan samplePlan --genome 'hg19' -profile conda

Mandatory arguments:
  --reads [file]                Path to input data (must be surrounded with quotes)
  --samplePlan [file]           Path to sample plan input file (cannot be used with --reads)
  --genome [str]                Name of genome reference
  -profile [str]                Configuration profile to use. test / conda / multiconda / path / multipath / singularity / docker / cluster (see below)

Inputs:
  --design [file]               Path to design file for extended analysis  
  --singleEnd [bool]            Specifies that the input is single-end reads

Skip options: All are false by default
  --skipSoftVersion [bool]      Do not report software version
  --skipMultiQC [bool]          Skips MultiQC

Other options:
  --outDir [file]               The output directory where the results will be saved
  -name [str]                   Name for the pipeline run. If not specified, Nextflow will automatically generate a random mnemonic

======================================================================
Available Profiles

  -profile test                Set up the test dataset
  -profile conda               Build a single conda for with all tools used by the different processes before running the pipeline
  -profile multiconda          Build a new conda environment for each tools used by the different processes before running the pipeline
  -profile path                Use the path defined in the configuration for all tools
  -profile multipath           Use the paths defined in the configuration for each tool
  -profile docker              Use the Docker containers for each process
  -profile singularity         Use the singularity images for each process
  -profile cluster             Run the workflow on the cluster, instead of locally
```

## Quick run

The best way to try the geniac-demo pipeline is to run it on the test data which is provided as a toy example. However, if you want to run it with your own data, you will find below the details of the options which are available.
Assume that the pipeline has been installed  with geniac in `${HOME}/tmp/myPipeline/install`. Then go inside the `${HOME}/tmp/myPipeline/install/pipeline` folder where is located the `main.nf` Nextflow file.

### Run the pipeline on the test dataset


```bash
nextflow run main.nf -profile test,multiconda
```

See the file `conf/test.config` to set your test dataset.


### Defining the '-profile'

By default (without any profile), Nextflow excutes the pipeline locally, expecting that all tools are available from your `PATH` environment variable.

Several [Nextflow profiles](profiles.md) are available after installation with geniac that allow:
* the use of [conda](https://docs.conda.io) or containers instead of a local installation,
* the submission of the pipeline on a cluster instead of on a local architecture.

The description of each profile is available on the help message (see above).

### Run the pipeline locally, using a global environment where all tools are installed

```bash
-profile path --globalPath /my/path/to/bioinformatics/tools
```

### Run the pipeline on the cluster, using the Singularity containers

```bash
-profile cluster,singularity --singularityPath /my/path/to/singularity/containers
```

### Run the pipeline on the cluster, building multiconda environments

```bash
-profile cluster,multiconda --condaCacheDir /my/path/to/condaCacheDir

```

## Running the pipeline

The typical command for running the pipeline is as follows:
```bash
nextflow run main.nf --reads '*_R{1,2}.fastq.gz' -profile singularity
```

This will launch the pipeline with the `singularity` configuration profile. See [Nextflow profiles](#nextflow-profiles) and [`-profile`](#-profile) for more information about profiles.

Note that the pipeline will create the following files in your working directory:

```bash
work            # Directory containing the nextflow working files
results         # Finished results (configurable, see below)
.nextflow.log   # Log file from Nextflow
.nextflow       # Hidden folder for Nextflow
```

You can change the output directory using the `--outDir/-w` options.

## Main arguments

### `-profile`

Use this option to set the [Nextflow profiles](profiles.md). For example:

```bash
-profile singularity,cluster
```

### `--reads`
Use this to specify the location of your input FastQ files. For example:

```bash
--reads 'path/to/data/sample_*_{1,2}.fastq'
```

Please note the following requirements:

1. The path must be enclosed in quotes
2. The path must have at least one `*` wildcard character
3. When using the pipeline with paired end data, the path must use `{1,2}` notation to specify read pairs

If left unspecified, a default pattern is used: `data/*{1,2}.fastq.gz`


### `--samplePlan`


Use this to specify a sample plan file instead of a regular expression to find FastQ files. For example :

```bash
--samplePlan 'path/to/data/samplePlan.csv
```

A sample plan is a csv file (comma separated) that lists all the samples with a biological IDs.
The sample plan is expected to contain the following fields (with no header):

```
SAMPLE_ID,SAMPLE_NAME,path/to/R1/fastq/file,path/to/R2/fastq/file (for paired-end only)
```
See [samplePlan](../test/samplePlan.csv) for sample plan example.

### `--design`

Specify a `design` file for extended analysis.

```bash
--design 'path/to/data/design.csv'
```

A design control is a csv file that list all experimental samples, their IDs, the associated control as well as any other useful metadata.
The design is expected to be created with the following header :

```bash
SAMPLE_ID | CONTROL_ID 
```

See [design](../test/design.csv) for a design file example.

The `--samplePlan` and the `--design` will be checked by the pipeline and have to be rigorously defined in order to make the pipeline work.  
If the `design` file is not specified, the pipeline will run over the first steps but the downstream analysis will be ignored.

## Inputs

### `--singleEnd`

By default, the pipeline expects paired-end data. If you have single-end data, you need to specify `--singleEnd` on the command line when you launch the pipeline. A normal glob pattern, enclosed 
in quotation marks, can then be used for `--reads`. For example:

```bash
--singleEnd --reads '*.fastq.gz'
```

## Nextflow profiles

Different Nextflow profiles can be used. See [Profiles](profiles.md) for details end [`-profile`](#-profile).

## Job resources

Each step in the pipeline has a default set of requirements for number of CPUs, memory and time (see the [`conf/process.conf`](../conf/process.config) file). 
For most of the steps in the pipeline, if the job exits with an error code of `143` (exceeded requested resources) it will automatically resubmit with higher requests (2 x original, then 3 x original). If it still fails after three times then the pipeline is stopped.

## Other command line parameters

### `--skip*`

The pipeline is made with a few *skip* options that allow to skip optional steps in the workflow.
The following options can be used:
* `--skipFastqc`
* `--skipMultiqc`

### `--metadata`
Specify a two-columns (tab-delimited) metadata file to display in the final Multiqc report.

See [test/metadata.tsv](../test/metadata.tsv) for a metadata file example.

### `--outDir`
The output directory where the results will be saved.

### `-name`
Name for the pipeline run. If not specified, Nextflow will automatically generate a random mnemonic.

This is used in the MultiQC report (if not default) and in the summary HTML.

**NB:** Single hyphen (core Nextflow option)

### `-resume`
Specify this when restarting a pipeline. Nextflow will used cached results from any pipeline steps where the inputs are the same, continuing from where it got to previously.

You can also supply a run name to resume a specific run: `-resume [run-name]`. Use the `nextflow log` command to show previous run names.

**NB:** Single hyphen (core Nextflow option)

### `-c`
Specify the path to a specific config file (this is a core Nextflow command).

**NB:** Single hyphen (core Nextflow option)

Note - you can use this to override pipeline defaults.

### `--maxMemory`
Use to set a top-limit for the default memory requirement for each process.
Should be a string in the format integer-unit. eg. `--maxMemory '8.GB'`

### `--maxTime`
Use to set a top-limit for the default time requirement for each process.
Should be a string in the format integer-unit. eg. `--maxTime '2.h'`

### `--maxCpus`
Use to set a top-limit for the default CPU requirement for each process.
Should be a string in the format integer-unit. eg. `--maxCpus 1`

### `--multiqcConfig`
Specify a path to a custom MultiQC configuration file.

