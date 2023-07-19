#!/bin/bash

for USER in `cat user_list.txt`; do 
 passwd -x -1 ${USER} ; usermod -G sftpuser $USER; 
done

while read -r source_dir target_dir _; do
  if [[ -n $target_dir ]]; then
    mkdir -p "$target_dir"
    
    # Extract the user owner from string1
    user_owner=$(echo "$target_dir" | cut -d'/' -f3)
    
    chown "$user_owner":hftp "$target_dir"
    chmod 2770 "$target_dir"
    echo "Created directory: $target_dir"
  fi
done < ftp_fstab
