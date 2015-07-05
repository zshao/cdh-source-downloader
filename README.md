README for cdh-source-downloader
========

This script (./run.sh) automates the following tasks:
* Download CDH source code from cloudera.com
* Extract the archive
* Add all the files to git
* Add .gitignore

Recommended usage:
* Run cdh-source-downloader/run.sh instead of ./run.sh, so the newly created git repo are not nested.