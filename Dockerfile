FROM ubuntu:latest

# Set the working dir to /home
WORKDIR /home

# Update package list and install acl and sudo
RUN apt-get update && apt-get install -y acl sudo adduser

# Copy the home dir contents into the container at /home
COPY . /home/

# Add execute permissions to your bash scripts
RUN chmod +x /home/*.sh

# Append custom aliases directly to /etc/bash.bashrc
COPY custom_bashrc /home/custom_bashrc
RUN cat /home/custom_bashrc >> /etc/bash.bashrc

# Set the default command to run a login shell
CMD ["bash", "-l"]
