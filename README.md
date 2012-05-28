This repo has scripts to deploy both core and webapp.

Usage
-----
Install and run the script by by logging in to a fresh server and running:

    apt-get install git-core
    git clone git://github.com/total-impact/total-impact-deploy.git
    total-impact-deploy
    ./deploy.sh

That's it. You'll also need to supply two passwords:

1. The password of the "ti" user that'll be created to host the files.
1. The passphrase to unlock db and api credentials. (still working on this bit)
