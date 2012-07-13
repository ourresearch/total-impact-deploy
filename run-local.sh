#!/bin/sh


# Runs the three python scripts (webapp, api, and backend) needed to 
# make TI run completely locally, sending log output to local3 
# (from there, syslog.conf can send it to remote logging like Papertrail; 
# instructions on this are in installation.md.
#
# USAGE: 
# if needed, change the locations for the files to run.
# run "source run-local.sh", and you're done.
# to restart, just close the terminal tab, and run this again in a new tab.

export API_ROOT="localhost:5001"
echo "changed API_ROOT to localhost:5001"

cd ~/projects/total-impact-webapp
source venv/bin/activate
python run.py | logger -p local3.debug &
echo "starting webapp"

cd ~/projects/total-impact-core
source venv/bin/activate
python run.py | logger -p local3.debug &
echo "starting api"

python totalimpact/backend.py | logger -p local3.debug &
echo "starting backend"
