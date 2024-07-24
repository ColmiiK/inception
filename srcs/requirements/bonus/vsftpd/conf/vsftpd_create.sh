#!/bin/bash

mkdir -p /var/www/html
adduser $FTP_USER --disabled-password
echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd &> /dev/null
chown -R $FTP_USER:$FT_USER /var/www/html
echo "$FTP_USER" | tee -a /etc/vsftpd.userlist &> /dev/null

/usr/sbin/vsftpd /etc/vsftpd.conf
