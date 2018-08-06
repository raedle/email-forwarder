#!/bin/bash

sed -i "s/EF_FORWARD_EMAIL/$EF_FORWARD_EMAIL/g" /root/.procmailrc
sed -i "s/EF_IMAP_SERVER/$EF_IMAP_SERVER/g" /root/.fetchmailrc
sed -i "s/EF_USERNAME/$EF_USERNAME/g" /root/.fetchmailrc
sed -i "s/EF_PASSWORD/$EF_PASSWORD/g" /root/.fetchmailrc

touch /root/procmail.log
touch /root/fetchmail.log

# RUN CRON in foreground
/usr/sbin/crond -f -l 10