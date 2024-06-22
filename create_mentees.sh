#!/bin/bash

# Path to the input file
input_file="/home/menteeDetails.txt"

# Base directory for mentees
base_dir="/home/users/core/mentees"

# Read the input file line by line, skipping the first line
sudo tail -n +2 "$input_file" | while IFS=' ' read -r name rollno; do
    # Create the user account without creating a home directory
    sudo useradd -M -s /bin/bash "$name"

    # Create the user's home diretory in the mentees directory
    user_home="$base_dir/$name"
    sudo mkdir -p "$user_home"
    sudo chown "$name:$name" "$user_home"

    # Set the user's home directory
    sudo usermod -d "$user_home" "$name"

    # Create the required text files in the user's home directory
    sudo touch "$user_home/domain_pref.txt"
    sudo touch "$user_home/task_completed.txt"
    sudo touch "$user_home/task_submitted.txt"
    sudo chown "$name:$name" "$user_home/domain_pref.txt"
    sudo chown "$name:$name" "$user_home/task_completed.txt"
    sudo chown "$name:$name" "$user_home/task_submitted.txt"

    # Add users to group mentees
    sudo usermod -aG mentees "$name"

    echo "alias submitTask='bash /home/submit_task.sh'" >> /home/users/core/mentees/$name/.bashrc
    source /home/users/core/mentees/$name/.bashrc

    echo  "User '$name' created with '$rollno' with home directory '$user_home'."
done

echo "All mentees have been processed."

