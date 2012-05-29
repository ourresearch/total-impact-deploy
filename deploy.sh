#! /bin/bash

# Sets up a running total-impact from a bare Ubuntu 10.04 Server install.
#
# USAGE
# -----
# See the README.md file at https://github.com/total-impact/total-impact-deploy/blob/master/README.md

# housekeeping
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#source ${DIR}/lib.sh

# set the hostname. from http://library.linode.com/getting-started#sph_ubuntu-debian
echo "jc" > /etc/hostname
hostname -F /etc/hostname

apt-get update
apt-get upgrade --assume-yes

# create new user ti
useradd -d /home/ti -m ti
chsh -s /bin/bash ti # use bash shell for ti
passwd ti

#download the total-impact application code
cd /home/ti
# assume user's already installed git, in order to get this script.
git clone git://github.com/total-impact/total-impact-core
git clone git://github.com/total-impact/total-impact-webapp

chown -R ti /home/ti/total-impact-core
chown -R ti /home/ti/total-impact-webapp

# install python dependencies
apt-get install python-setuptools
easy_install virtualenv
curl http://python-distribute.org/distribute_setup.py | python
curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python

# install the webapp
cd total-impact-webapp
pip install .
cd ..

# install core
cd total-impact-core
apt-get install gcc --assume-yes
apt-get install python2.6-dev --assume-yes
apt-get install libxslt-dev libxml2-dev --assume-yes
pip install .
cd ..

# install nginx and gunicorn
pip install gunicorn
apt-get install nginx


