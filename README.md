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
For a quick and blind deployment run

    wget -O - https://raw.githubusercontent.com/matteoferla/Michelanglo-and-Venus/main/app_deployment.sh | bash -
    

## Folder structure

The folder structure of the full stack would looks like:

1. michelanglo/app
2. michelanglo/analysis
3. michelanglo/transpiler
4. michelanglo/protein-data
5. michelanglo/user-data
    
The first three repos contain python3.7+ modules which will have been installed.
Unless they were installed in develop mode, they reside with
the other python modules, so could be deleted, with the caveat that three extra files may be used in the app repo.

* `demo.db` is a example sql database
* `*.ini` are config files
* `app.py` is a small snippet that loads the app and runs it with waitress.

For a note about basics of running a Pyramid application see [app serving](app_serving.md).

The folder `user-data` is created by the application at runtime
in the location specified by config setting `michelanglo.protein_data_folder`.

The folder `protein-data` should have been created by running `create.py` of the analysis module,
or by uncompressing the human dataset —location specified by config setting `michelanglo.user_data_folder`.

If the protein analysis module is being run by itself, then it is specified in the `global_settings`
object —same as `Protein.settings` etc. Say: 

    from michelanglo_protein import global_settings, Structure, ProteinAnalyser
    global_settings.startup('/👾👾/👾👾👾/michelanglo/protein-data')
    
    protein = ProteinAnalyser(uniprot='👾👾👾')
    protein.mutation = Mutation('👾👾👾')
    ddG = protein.analyse_FF()

For more, see the relevant modules.
                          
