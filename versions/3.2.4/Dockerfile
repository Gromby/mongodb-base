FROM ubuntu:14.04
MAINTAINER Gromby Devops <devops@gromby.com>

# Import the public key used by the package management system
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# Create a list file for MongoDB
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Reload local package database
RUN apt-get update

# Install a specific release of MongoDB
RUN apt-get install -y mongodb-org=3.2.4 \
  mongodb-org-server=3.2.4 \
  mongodb-org-shell=3.2.4 \
  mongodb-org-mongos=3.2.4 \
  mongodb-org-tools=3.2.4

# Create MongoDB data and log directory
RUN mkdir -p /var/lib/mongodb && \
  mkdir -p /var/log/mongodb

# Pin a specific version of MongoDB
RUN echo "mongodb-org hold" | sudo dpkg --set-selections && \
  echo "mongodb-org-server hold" | sudo dpkg --set-selections && \
  echo "mongodb-org-shell hold" | sudo dpkg --set-selections && \
  echo "mongodb-org-mongos hold" | sudo dpkg --set-selections && \
  echo "mongodb-org-tools hold" | sudo dpkg --set-selections

CMD ["mongod","--dbpath=/var/lib/mongodb"]