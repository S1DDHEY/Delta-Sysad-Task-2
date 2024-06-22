#!/bin/bash

# Add users directory
sudo mkdir -p /home/users

# New home base directory
NEW_HOME_BASE="/home/users"

add_and_move_user() {
    local username=$1

        # Add user
        sudo adduser --gecos "" "$username" >/dev/null

	# Add core to group sudo
	sudo usermod -aG sudo "$username"

        if [ $? -eq 0 ]; then
	    echo "Successfully added user: $username"

            # Move the home directory to the new location
            OLD_HOME_DIR="/home/$username"
	    NEW_HOME_DIR="$NEW_HOME_BASE/$username"

            if [ -d "$OLD_HOME_DIR" ]; then
		sudo mv "$OLD_HOME_DIR" "$NEW_HOME_DIR"
		sudo chown -R "$username:$username" "$NEW_HOME_DIR"

                # Delete the initial home directory of it exists
		if [ -d "$OLD_HOME_DIR" ]; then
		    sudo rm -rf "$OLD_HOME_DIR"
		fi

	    else
		echo "Initial home directory $OLD_HOME_DIR does not exist for user $username"
	    fi

	    # Update the user's home directory path in /etc/passwd
	    sudo usermod -d "$NEW_HOME_DIR" "$username"

        else
            echo "Failed to add user: $username"
        fi
}

add_and_move_user "core"

# Add a mentees_domain.txt file to core's home directory
sudo echo "name rollno domain" > /home/users/core/mentees_domain.txt
# Add core to root group
sudo usermod -aG root core
# Add groups
sudo groupadd mentors
sudo groupadd mentees

