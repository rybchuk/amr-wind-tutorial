# 01_compiling.md
[Official documentation on compiling](https://exawind.github.io/amr-wind/user/build.html)

Before you run AMR-Wind, you must first compile the LES solver. You may also need to compile additional codes in tandem (e.g., OpenFAST if you want to model turbines). There are two general approaches to compiling AMR-Wind: building from source or using [Spack-Manager](https://github.com/psakievich/spack-manager) ([docs](https://sandialabs.github.io/spack-manager/index.html)). I recommend Spack-Manager, because it can get very complicated to manually compile with all the interdependencies.

In my mind, [Spack](https://github.com/spack/spack) and Spack-Manager give us something like Python's `conda install <library>`, except for software packages. Spack is a hefty and powerful tool, and Spack-Manager was developed to help simplify it for ExaWind users.

If you're trying to quickly set up AMR-Wind, the [Snapshot Developer Workflow Example](https://sandialabs.github.io/spack-manager/user_profiles/developers/snapshot_workflow.html) is a quick way to cover the basics. I'll present a streamlined process here, but if things break, check out the official docs.

First, download Spack-Manager. I recommend setting it up somewhere where you have lots of storage (e.g., on Eagle, a `/projects/` directory instead of `/home/`), because it's easy to run out of space quickly. I'll be demoing this install on the DelftBlue supercomputer.

```
export SPACKMANDIR=<fill in the directory>
cd ${SPACKMANDIR}
git clone --recursive https://github.com/sandialabs/spack-manager.git
```

Then activate it:
```
export SPACK_MANAGER=${SPACKMANDIR}/spack-manager && source ${SPACK_MANAGER}/start.sh && spack-start
```

Before we install anything, let's get some info about the codes that Spack can see
```
spack info amr-wind
```
and
```
spack info openfast
```
With these commands, you can see info like the safe versions as well as different flags that can get specified.

Also, before we compile, let's load the version of `gcc` that we will be using
```
module load 2022r2
module avail
module load gcc/11.2.0
```

With this done, let's now create our environment.
```
mkdir ${SPACKMANDIR}/spack-july2023
cd ${SPACKMANDIR}/spack-july2023
quick-create-dev -d ${SPACKMANDIR}/spack-july2023 -s openfast@master%gcc@11.2.0 amr-wind@main+openfast+hdf5%gcc@11.2.0
```
This `quick-create-dev` command has flags selected so that that AMR-Wind will work with OpenFAST, and AMR-Wind also has the option to save out certain files using HDF5. If you forget the `+openfast` flag, your AMR-Wind simulations of turbines will crash and give you a confusing error message.

After creating the environment, I will do some stuff to ensure I get the exact versions of the codes I would like. I'll note that there are proper ways to get specific code versions (I believe tied to externals), but the following hacky approach has worked for me.

Looking through [AMR-Wind commits](https://github.com/Exawind/amr-wind/commits/main), I've determined that I want the code at SHA 4b71037218723e0c63d54c140423ef503ac3c912, and looking through [OpenFAST commits](https://github.com/OpenFAST/openfast/commits/main), I want 18704086dad861ab13daf804825da7c4b8d59428. That OpenFAST commit corresponds to the release of version 3.4.1. In theory, we should be able to grab specific versions of OpenFAST via our `quick-create-dev` command, but `spack info openfast` didn't have `3.4.1` listed, so this is a different approach to get our desired version of OpenFAST. (Note: on July 18, 2023, OpenFAST 3.4.1 is the newest version of OpenFAST that is supported by AMR-Wind)

To download the desired version of AMR-Wind, run
```
rm -rf amr-wind
git clone --recursive git@github.com:Exawind/amr-wind.git
cd amr-wind
git checkout 4b71037218723e0c63d54c140423ef503ac3c912
cd ..
```
If the SSH link `git@github.com:Exawind/amr-wind.git` didn't work, try the HTTPS link `https://github.com/Exawind/amr-wind.git`.

Similarly, for OpenFAST, run
```
rm -rf openfast
git clone --recursive git@github.com:OpenFAST/openfast.git
cd openfast
git checkout 18704086dad861ab13daf804825da7c4b8d59428
cd ..
```

Now that we have our specific versions of everything, let Spack compile everything by running
```
spack install
```
This process will take some time, and it will generate a large wall of text. Once that command is done running, we can test 


In `include.yaml`, we modified 
```
perl:
  require: '@5.34.0'
```

Alternatively, you found where DelftBlue's … `/~/mehtabkhan/.spack_downloads/_source-cache/archive/*.tar.gz` and unziped, and then they moved it to the destination in `/home/mehtabkhan/spack-manager/stage/spack-stage-perl-3.4.1`

### Additional details for turbine simulations
If you are simulating an OpenFAST turbine, you will probably need a controller for your turbine. I recommend [ROSCO](https://github.com/NREL/ROSCO). The full installation docs are [here](https://rosco.readthedocs.io/en/latest/source/install.html#full-rosco-installation), but we only need the controller from ROSCO, so the installation process is light. Below, I'll document what I do on Eagle.

0. `module load` the libraries that you will be loading when you run AMR-Wind, e.g. on Eagle `module load gcc/8.4.0 mpt cmake` (note: I run with `gcc/8.4.0` instead of `11.2.0` like I demoed for DelftBlue)
1. `cd` into a directory (ideally somewhere in `/projects/`), and clone ROSCO `git clone https://github.com/NREL/ROSCO.git`
2. Compile ROSCO
```
# Compile ROSCO
cd ROSCO/ROSCO
mkdir build
cd build
cmake ..                        # Mac/linux only
make install
```

This will generate a file called `libdiscon.so`, and we will later point to this file in OpenFAST configuration files.

