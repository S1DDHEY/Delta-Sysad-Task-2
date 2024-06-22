#!/bin/bash

# Set the group ownership to 'mentors' for the mentees homoe directories
for i in /home/users/core/mentees/*; do
    sudo chgrp mentors "$i"
    sudo chmod 770 "$i"
done

# Set the group ownership to 'mentors' for the mentors homoe directories
for j in /home/users/core/mentors/*; do
    sudo chgrp mentors "$j"
    sudo chmod 700 "$j"
done

# Set permissions for the parent directories
sudo chmod 750 /home/users/core

# Set permissions for domainPref.sh file
sudo setfacl -m g:mentees:r-x /home/domainPref.sh
sudo setfacl -m g:mentors:r-x /home/domainPref.sh

echo "Permissions have been set up successfully."
