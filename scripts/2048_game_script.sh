#!/bin/bash
# This script automate the deployment of the 2048 game application
# Author: Hung Lai

# Print a given message in color
function print_color(){
  case $1 in
    "green") COLOR="\033[0;032m";;
    "red") COLOR="\033[0;031m";;
    *) COLOR="\033[0m";;
  esac

  echo -e "${COLOR} $2\033[0m"
}

# Custom error handler
function handle_error() {
    print_color "red" "Error on line $1"
    exit 1
}

# Enable the custom error handler
trap 'handle_error $LINENO' ERR

# Exit the script on any command with non-zero exit code
set -e

#Update package information:
sudo apt-get update
#Install prerequisite packages:
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
#Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#Set up the Docker stable repository:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#Update package information again:
sudo apt-get update
#Install Docker CE (Community Edition):
print_color "green" "Installing Docker..."
sudo apt-get install docker-ce
#Start Docker and enable it to start at boot:
sudo systemctl start docker
sudo systemctl enable docker

#Check if Docker is active, else exit with code 1
is_active=$(sudo systemctl is-active docker)

if [[ $is_active == "active" ]]
then
  print_color "green" "Docker is active"
else
  print_color "red" "Docker is not active"
  exit 1
fi

# Create and change directory to "2048"
mkdir -p 2048 && cd 2048


# Create a Dockerfile with the game 2048 setup
cat <<EOF > Dockerfile
# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Update the package list of the base image
RUN apt-get update

# Install nginx, zip, and curl packages
RUN apt-get install -y nginx zip curl

# Update the nginx configuration to run in the foreground (required for Docker)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Download the source code of the game "2048" from GitHub into the nginx HTML directory
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master

# Unzip the downloaded file, move the contents to the nginx root directory, and then remove unnecessary files
RUN cd /var/www/html/ && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip

# Inform Docker that the container will listen on port 80
EXPOSE 80

# Command to run when the container starts. This starts the nginx server with the specified configuration.
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
EOF

# Build the Docker image for the game
print_color "green" "Building 2048 Docker Image..."
sudo docker build . -t 2048-image

# Run the Docker container with the game, mapping the container's port 80 to the host's port 80
print_color "green" "Running 2048 Game in Docker..."
sudo docker run -d -p 80:80 2048-image

