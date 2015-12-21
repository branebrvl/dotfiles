ulimit -n 10024

# Load paths and environment variables
source ~/.shellvars
source ~/.shellpaths
source ~/.shellaliases
# source ~/.shellactivities
source ~/.nvm/nvm.sh
nvm use 0.10
source /usr/local/bin/virtualenvwrapper.sh

export DOCKER_HOST=tcp://192.168.99.100:2376
export DOCKER_CERT_PATH=$HOME/.docker/machine/machines/drastic-admin-api
export DOCKER_TLS_VERIFY=1
