ulimit -n 10024

# Load paths and environment variables
source ~/.shellvars
source ~/.shellpaths
source ~/.shellaliases
# source ~/.shellactivities

export NVM_DIR="/Users/bvladisavljev/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
source ~/.nvm/nvm.sh
nvm use v6.9.1
# source /usr/local/bin/virtualenvwrapper.sh
