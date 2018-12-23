# mwe-singularity-checkpoint

[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/2039)
[![CircleCI](https://circleci.com/gh/mmore500/mwe-singularity-checkpoint.svg?style=svg)](https://circleci.com/gh/mmore500/mwe-singularity-checkpoint)

A minimal working example of DMTCP checkpoint-restart inside a Singularity container.

# Usage

## Prerequisites

You'll need to have [Singularity](https://www.sylabs.io/guides/3.0/user-guide/) installed locally.

## Pull Container from SingularityHub...

```
make shub
```

## ... or Build Container Locally

```
make
```

## Interactive Demonstration

```
make demonstrate
```

## Non-interactive Test

```
make test
```

# Notes

This example uses [Singularity](https://github.com/sylabs/singularity) `v2.6.x` and [DMTCP](https://github.com/dmtcp/dmtcp) `v3.0.0` (e.g., from the tip of master circa December 2018).
I didn't play around with other versions of these softwares.

Unfortunately, this example doesn't seem to be totally portable.
I was able to get the example to run on my own laptop
In order to get the checkpoint/restarts to work on CircleCI's virtual machines (i.e., `machine`), I had to disable a runtime assert in the source (see [here](https://github.com/mmore500/dmtcp/commit/b8be8be2874258d2f45324a42d609c0c63da0079)).
On a [Michigan State University High Performance Computing Center](2.5.2-dist
) development node, which runs CentOS 7 and uses Singularity `v2.5.2-dist`, the demonstration currently crashes out at the first attempted checkpoint.
The iCER staff put together a nice tutorial of DMTCP checkpointing on the HPCC [here](https://wiki.hpcc.msu.edu/display/ITH/Check+Point+with+DMTCP).
With some further finessing along those lines, checkpointing Singularity containers on our HPCC *might* be possible.

# Acknowledgement

`.circleci` materials were pilfered from Container Tool's [example builder for Singularity containers using Circle Continuous Integration](https://github.com/singularityhub/circle-ci).
Thanks [@vsoch](http://github.com/vsoch)!
