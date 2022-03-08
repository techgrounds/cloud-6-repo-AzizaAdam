#!/bin/sh
sudo su
apt update
apt install apache2 -y
ufw allow 'Apache'
