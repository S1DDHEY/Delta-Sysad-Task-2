FROM ubuntu:latest

# Set the working dir to /home
WORKDIR /home

# Update package list and install acl, sudo and apache2
RUN apt-get update && apt-get install -y acl sudo adduser apache2 tmux

# Copy the home dir contents into the container at /home
COPY . /home/

# Add execute permissions to your bash scripts
RUN chmod +x /home/*.sh

# Append custom aliases directly to /etc/bash.bashrc
COPY custom_bashrc /home/custom_bashrc
RUN cat /home/custom_bashrc >> /etc/bash.bashrc

# Set the ServerName globally in Apache configuration
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Expose port 80 to the outside world
EXPOSE 80

# Set the default command to run a login shell
CMD ["bash", "-l"]
