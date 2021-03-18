# Start a docker image with globus-cli utilities on MGI

# See doc/README.globus_testing.md for details of preliminary work and
# choices of docker images
IMAGE="liambindle/globus-cli"

# [WUDocker](https://github.com/ding-lab/WUDocker.git) is utility for starting 
# docker images on WU systems
START_DOCKER="../WUDocker"
bash $START_DOCKER/start_docker.sh -M MGI -I $IMAGE



