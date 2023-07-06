# 00_intro.md
AMR-Wind is a large-eddy simulation code purpose-built for simulations of individual wind turbines as well as wind farms. The official documentation is [here](https://exawind.github.io/amr-wind/) and the official codebase is [here](https://github.com/Exawind/amr-wind). As of June 2023, the code has been used to do big wind simulations with [541 turbines](https://iopscience.iop.org/article/10.1088/1742-6596/2505/1/012023/meta) in a 100 km x 100 km domain, and it has been used for blade-resolved simulations of small clusters of turbines. 

AMR-Wind was designed to run on both CPUs and GPUs. In practice, I think people mostly run on CPUs today. But, as our supercomputer systems shift to get their compute power from GPUs, I anticipate that AMR-Wind users will shift more heavily to GPUs.

AMR-Wind is built on top of [incflo](https://github.com/AMReX-Codes/incflo) ("incompressible flow"), which is on turn built on the block-structured adaptive mesh refinement code [AMReX](https://amrex-codes.github.io/amrex/). AMReX was developed with significant help from the U.S. Department of Energy's Exascale Computing Project (ECP). AMReX serves as the basis for many other codes, with applications ranging from combustion to atsrophysics. I'll note here that, while you can in theory run AMR-Wind with a grid that is dynamically refined, in practice AMR-Wind is usually run with a static grid. 

AMR-Wind is a component of the broader [ExaWind](https://github.com/Exawind) project. Some other relevant codebases include:
* [Nalu-Wind](https://github.com/Exawind/nalu-wind) - an unstructured flow solver for wind turbines and wind farms. It is possible to run blade-resolved CFD, where AMR-Wind is used further from the turbine, and Nalu-Wind is used near the turbine.
* [Tioga](https://github.com/Exawind/tioga) - a code that acts as the interface between structured and unstructured grids.
* [OpenFAST](https://github.com/OpenFAST/openfast) - a CPU-based code to do detailed modeling of turbine dynamics
* [OpenTurbine](https://github.com/Exawind/openturbine) - a new GPU-compatible code to do detailed modeling of turbine dynamics (under heavy development, as of FY23)
* [amrwind-frontend](https://github.com/lawrenceccheung/amrwind-frontend) - A tool to help set up, visualize, and post-process AMR-Wind simulations. It has a GUI interface as well as a Python interface.

In addition to the official docs, here are some other resources that might be helpful.
* Lawrence Cheung's [full-scale simulation](https://github.com/lawrenceccheung/AWAKEN_summit_setup/tree/main/UnstableABL_farmrun1) with AMR-Wind as part of the AWAKEN project ([the precursor simulation without turbines](https://github.com/lawrenceccheung/AWAKEN_summit_setup/blob/main/UnstableABL_farmrun1/UnstableABL_precursor2.inp), [the turbine simulation](https://github.com/lawrenceccheung/AWAKEN_summit_setup/blob/main/UnstableABL_farmrun1/UnstableABL_farmrun1.inp))
* Some [extra guidance](https://github.com/lawrenceccheung/amrwind-frontend/blob/afbc1dd284095ee869ba8a9cd3760fdf8b08ca82/docs/openfast_turbine.md) on AMR-Wind simulations from Lawrence Cheung
* Regis Thedin's [windtools](https://github.com/rthedin/windtools/blob/master/windtools/amrwind/post_processing.py), for post-processing output of AMR-Wind
* AMReX documentation on how to post-process [plotfiles](https://amrex-codes.github.io/amrex/docs_html/Visualization_Chapter.html) (aka data found in `plt#####/`)
