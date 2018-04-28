################################################################################
# Basic bootstrap definition to build Ubuntu container from Docker container
################################################################################

Bootstrap:docker
From:ubuntu:latest

%labels
Maintainer Matthew Andres Moreno
Version 0.0.0

################################################################################
# Copy any necessary files into the container
################################################################################
%files
. /opt/mwe-singularity-criu

%post
################################################################################
# Install additional packages
################################################################################
apt-get update

apt-get install -y criu
apt-get install -y htop

chmod 777 -R /opt

################################################################################
# Run the user's login shell, or a user specified command
################################################################################
%runscript
/opt/mwe-singularity-criu/test.sh
