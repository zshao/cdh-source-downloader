README for cdh-source-downloader
========

This script (./run.sh) automates the following tasks:
1. Download CDH source code from cloudera.com
2. Extract the archive
3. Add all the files to git
4. Add .gitignore

Recommended usage:
* Run cdh-source-downloader/run.sh instead of ./run.sh, so the newly created git repo are not nested.