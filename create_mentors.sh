#!/bin/bash

# Path to the input file
input_file="/home/mentorDetails.txt"

# Base directory for mentors
base_dir="/home/users/core/mentors"

# Read the input file line by line
sudo tail -n +2 "$input_file" | while IFS=' ' read -r name domain mentee_capacity; do
    # Determine the directory based on the domain
    case $domain in
	web)
	    user_dir="$base_dir/Webdev"
	    ;;
	app)
	    user_dir="$base_dir/Appdev"
	    ;;
	sysad)
	    user_dir="$base_dir/Sysad"
	    ;;
	*)
	    echo ""
	    continue
	    ;;
	esac

    # Create the user account without creating a home direcotry
    sudo useradd -M -s /bin/bash "$name"

    # Create the user's home directory in the appropriate domain directory
    sudo mkdir -p "$user_dir/$name"
    sudo chown "$name:$name" "$user_dir/$name"

    # Set the user's home directory
    sudo usermod -d "$user_dir/$name" "$name"

    # Add users to mentors group
    sudo usermod -aG mentors "$name"

    # Add allocated mentees file to each mentor's home directory
    sudo touch "$user_dir/$name/allocatedMentees.txt"

    # Add sub directories to each mentor's home directory
    sudo mkdir -p "$user_dir/$name/submittedTasks"
    sudo mkdir -p "$user_dir/$name/submittedTasks/task1"
    sudo mkdir -p "$user_dir/$name/submittedTasks/task2"
    sudo mkdir -p "$user_dir/$name/submittedTasks/task3"

    # Add alias submitTask to each mentors's .bashrc file
    echo "alias submitTask='bash /home/submit_task.sh'" >> "$user_dir/$name/.bashrc"
    source "$user_dir/$name/.bashrc"

    echo "User '$name' created with home directory '$user_dir/$name'."
done < "$input_file"

echo "All the mentors have been processed."
