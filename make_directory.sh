#!/bin/bash

# Make directories for mentors and mentees under core's home directory
sudo mkdir -p /home/users/core/mentors
sudo mkdir -p /home/users/core/mentees
echo "Directories for mentors and mentees created under core's home directory"

# Make respective directories for Webdev Appdev Sysad
domains=("Webdev" "Appdev" "Sysad")

for i in "${domains[@]}"; do
    sudo mkdir -p /home/users/core/mentors/$i
done
echo "Directories for respective domains created under core's home directory"

