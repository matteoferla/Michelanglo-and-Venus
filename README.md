# Michelanglo-and-Venus
Topmost repository for [the Michelaɴɢʟo webapp](https://michelanglo.sgc.ox.ac.uk/), including the Venus functionality.

## Overview
Michelaɴɢʟo is a complex web app built in Python3 with the Pyramid framework that uses backed both PyMOL and PyRosetta,
and contains a lot of data.

As a consequence, instead of having an unwieldy monolithic repository, it is split into multiple repositories:

* [App](https://github.com/matteoferla/MichelaNGLo-app):  Pyramid webserver
* [transpiler](https://github.com/matteoferla/MichelaNGLo-transpiler): conversion of PyMOL PSE files, Offset correction
* [protein-analysis](https://github.com/matteoferla/MichelaNGLo-protein-module): Feature mining and ∆∆G calculations
* [API](https://github.com/matteoferla/MichelaNGLo-api): Clientside Python3 API for easy interaction with the webapp (Not used in the webapp)
* [Human protein data](https://github.com/matteoferla/MichelaNGLo-human-protein-data): A data dump of the human files (Not used in the webapp, which uses a complete Uniprot Swissport dataset)
* [Venus benckmarking](https://github.com/matteoferla/validation_of_venus_ddG): Tests to benchmark Venus settings

Each of these has their own documentation. For the app, the site contains user-focused documentation, 
while the GitHub contains technical documentation.

The client-side Python API (technically an SDK) can be run on its own and can be pip-installed via `pip3 install michelanglo-api`.

The [protein analysis module](https://github.com/matteoferla/MichelaNGLo-protein-module) (usable without the app) can be used without the parsed Uniprot/gnomAD/PSP/etc data
for certain operations.

## Michelanglo/Venus deployment

For deployment notes of the web app and all the required submodules, see [app_deployment notes](app_deployment.md).
For a quick deployment run

    MIKE_SECRETCODE MIKE_SQL_URL
    wget -O - https://raw.githubusercontent.com/matteoferla/Michelanglo-and-Venus/main/app_deployment.sh | bash
