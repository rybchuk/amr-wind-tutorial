# An unofficial AMR-Wind tutorial
An opinionated guide for new AMR-Wind users, by Alex Rybchuk. After going through this guide, you should be able to run an LES simulation of a small wind farm in a weakly convective atmospheric boundary layer.

I'm initially putting together this repo as supporting material for an AMR-Wind crash course on July 4th, 2023 at TU Delft. The documentation here reflects my personal experience of using AMR-Wind, and while my guidance largely follows the [official documentation](https://exawind.github.io/amr-wind/), I'll also talk about different hacky things that don't represent "best practice".

With this in mind, it may be helpful to give context on how I use AMR-Wind. To date, I've largely used AMR-Wind for simulations of a single turbine as part of the RAAW field campaign as well as simulations of ~50 turbines as part of the AWAKEN field campaign. I've focused more-so on the atmosphere than on any turbines. I don't have experience with blade-resolved simulations or farm control, but this guide should be helpful if you are interested in those topics.

If something in this tutorial doesn't work, please post to the [issues board](https://github.com/rybchuk/amr-wind-tutorial/issues) on this repo. If you have broader questions about AMR-Wind, please post to the [issues board](https://github.com/Exawind/amr-wind/issues) there.