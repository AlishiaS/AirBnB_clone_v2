#!/usr/bin/env bash

# Preparing a web server on a remote host 


# Install Nginx if it's not already installed
sudo apt-get update
sudo apt-get install -y nginx

# Create a folder /data/ if it doesn't exist and create the folder /data/web_static/ 
# and the folder /data/web_static/releases/ and folder /data/web_static/shared/ 
# and folder /data/web_static/releases/test/.

mkdir -p /data/web_static/releases/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/

# Creating a fake html file to test nginx configuration

echo '
<html>
<body> 
  <h1> Welcome to nginx served web page </h1>
</body>
</html>
' > /data/web_static/releases/test/index.html

# Create symbolic link to /data/web_static/releases/test/ folder 

ln -sf /data/web_static/releases/test /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user and group 
chown -R ubuntu:ubuntu /data/

# Update the nginx configuration to serve the content of /data/web_static/current/

echo "
server {
listen 80 default_server;
listen [::]:80 default_server;
root /var/www/html;
index index.html index.htm index.nginx-debian.html;
location /hbnb_static {
alias /data/web_static/current;
}
}
" > /etc/nginx/sites-available/default

service nginx restart
