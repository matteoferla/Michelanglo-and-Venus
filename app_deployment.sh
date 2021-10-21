#!/bin/bash

for CMD in yum apt-get brew; do
$CMD > /dev/null
if [[ $? -ne 127 ]]; then
    echo command $CMD exists
    break
fi
done

sudo $CMD install sqlite
sudo $CMD install nodejs
sudo $CMD install npm

wget https://repo.anaconda.com/archive/Anaconda3-2021.04-Linux-x86_64.sh
bash Anaconda3-2021.04-Linux-x86_64.sh -b
conda update conda
conda create -n env python=3.8 anaconda
conda activate env
conda install -c schrodinger pymol
conda install -c conda-forge -y biopython

curl -u Academic_User:$PYROSETTAPASSWORD https://graylab.jhu.edu/download/PyRosetta4/archive/release/PyRosetta4.Release.python3.8.ubuntu/PyRosetta4.Release.python3.8.ubuntu.release-295.tar.bz2 -o /content/a.tar.bz2
tar -xf a.tar.bz2
pip install -e PyRosetta4.Release.python3.8.ubuntu.release-295/setup/
rm a.tar.bz2

mkdir michelanglo
cd michelanglo/

git clone https://github.com/matteoferla/MichelaNGLo-protein-analysis.git analysis
cd analysis
python setup.py install
#python create.py & #do this to get protein data. else:
mkdir ../protein-data
mkdir ../protein-data/reference
touch ../protein-data/reference/pdb_chain_uniprot.tsv
# end of hacky way round.

git clone https://github.com/matteoferla/MichelaNGLo-transpiler transpiler
cd ../transpiler
python setup.py install

# if you have a licence for font awesome do:
#git clone --recursive https://github.com/matteoferla/MichelaNGLo.git app
git clone https://github.com/matteoferla/MichelaNGLo.git app
# https://github.com/FortAwesome/Font-Awesome
cd app
sed -i 's/Font-Awesome-Pro\.git/Font-Awesome\.git/g' .gitmodules
git submodule update --init --recursive
npm install
cp demo.db mike.db
cp production.ini actual.ini

python app.py --config actual.ini > ../mike.log 2>&1