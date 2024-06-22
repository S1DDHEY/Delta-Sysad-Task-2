#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 <mentee_username> <roll_number> <domain1> <domain2> <domain3>"
    echo "Domains: web, app, sysad"
    exit 1
}

# Check if at least 3 arguments are provided (mentee_username, roll_number, and at least one domain)
if [ "$#" -lt 3 ]; then
    usage
fi

# Assign the first two arguments to the mentee_username and roll_number variables, and shift the rest to the domains array
mentee_username=$1
roll_number=$2
shift 2
domains=("$@")

# Define valid domains
valid_domain=("web" "app" "sysad")

# Check if provided domains are valid
for domain in "${domains[@]}"; do
    if [[ ! " ${valid_domain[*]} " =~ " ${domain} " ]]; then
        echo "Invalid domain: $domain"
        usage
    fi
done

# Define paths for the mentee's home directory and the domains preference files
mentee_home="/home/users/core/mentees/$mentee_username"
domain_pref_file="$mentee_home/domain_pref.txt"
core_mentees_file="/home/users/core/mentees_domain.txt"

# Clear the domain_pref.txt file before writing
> "$domain_pref_file"

# Add the provided domains to the mentee's domain_pref.txt file
for domain in "${domains[@]}"; do
    echo "$domain" >> "$domain_pref_file"
done

# Add the username, roll number, and domains to the core's mentees_domain.txt file
echo "$mentee_username $roll_number ${domains[*]}" >> "$core_mentees_file"

# Create directories for each domain inside the mentee's home directory
for domain in "${domains[@]}"; do
    domain_dir="$mentee_home/$domain"
    mkdir -p "$domain_dir"
done

echo "Domain preferences and directories setup completed for mentee $mentee_username."
