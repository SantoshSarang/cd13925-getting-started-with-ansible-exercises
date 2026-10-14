#!/bin/bash

declare -A ips=(
  ["ip-172-31-93-179.ec2.internal"]="ip-172-31-19-251.ec2.internal"
  ["ip-172-31-92-166.ec2.internal"]="ip-172-31-20-43.ec2.internal"
  ["ip-172-31-90-84.ec2.internal"]="ip-172-31-18-219.ec2.internal"
)

find . -type f -name 'inventory.ini' -print0 |
while IFS= read -r -d '' file; do
    for old_ip in "${!ips[@]}"; do
        new_ip="${ips[$old_ip]}"
        sed -i "s/${old_ip//./\\.}/${new_ip}/g" "$file"
    done
    echo "Updated: $file"
done
