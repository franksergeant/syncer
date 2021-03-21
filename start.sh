#! /bin/sh

# give root a random password 
echo -n 'root:'$(date | md5sum) | chpasswd

# run sshd in non-daemon mode
/usr/sbin/sshd -D


