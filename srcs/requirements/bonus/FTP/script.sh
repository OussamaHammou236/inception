#!/bin/bash

mkdir -p /var/run/vsftpd/empty && chmod 755 /var/run/vsftpd/empty

useradd -m $FTPUSER && echo "$FTPUSER:$FTPPASS" | chpasswd

usermod -d /var/www/wordpress/ $FTPUSER

chmod 777 /var/www/wordpress/

vsftpd /etc/vsftpd.conf