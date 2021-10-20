#!/bin/bash
sudo apt install sqlite
sudo apt install nodejs
sudo apt install npm

wget https://repo.anaconda.com/archive/Anaconda3-2019.10-MacOSX-x86_64.sh
bash Anaconda3-2019.10-MacOSX-x86_64.sh -b
conda update conda
conda create -n env python=3.7 anaconda
conda activate env
conda install -c schrodinger pymol
conda install -c conda-forge -y biopython

mkdir michelanglo
cd michelanglo/
git clone --recursive https://github.com/matteoferla/MichelaNGLo.git app
git clone https://github.com/matteoferla/MichelaNGLo-protein-module.git protein-module
git clone https://github.com/matteoferla/MichelaNGLo-transpiler transpiler
cd protein-module
python3 setup.py install
#python3 create.py & #do this to get protein data. else:
mkdir ../protein-data
mkdir ../protein-data/reference
touch ../protein-data/reference/pdb_chain_uniprot.tsv
# end of hacky way round.
cd ../transpiler
python3 setup.py install
cd ../app
python3 setup.py install
npm install
cp demo.db mike.db
PROTEIN_DATA='../protein-data' SECRETCODE=$MIKE_SECRETCODE SQL_URL=$MIKE_SQL_URL SLACK_WEBHOOK=$SLACK_WEBHOOK python3 app.py > ../mike.log 2>&1