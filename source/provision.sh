#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo apt-get install nodejs -y
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo npm install pm2 -g

sudo rm -rf /etc/nginx/sites-available/default
sudo cp app/default /etc/nginx/sites-available/
sudo systemctl restart nginx
sudo systemctl enable nginx
echo "export DB_HOST='mongodb://192.168.10.150:27017/posts'" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc
