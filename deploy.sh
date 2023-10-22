#!/bin/bash

# Update and upgrade Ubuntu packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Apache, MySQL, PHP, Git
sudo apt-get install -y apache2 mysql-server php php-mysql git

# Clone Laravel application from GitHub
git clone https://github.com/laravel/laravel /var/www/html/myapp

# Configure Apache virtual host
sudo cp /var/www/html/myapp/.env.example /var/www/html/myapp/.env
sudo chown -R www-data:www-data /var/www/html/myapp
sudo chmod -R 755 /var/www/html/myapp
sudo systemctl restart apache2

# Configure MySQL for the Laravel application
MYSQL_ROOT_PASS="<DB_ROOT_PASSWORD>"
DB_USER="<DB_USER>"
DB_PASSWORD="<DB_PASSWORD>"
DB_NAME="<DB_NAME>"

sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Update .env file with MySQL credentials
sed -i "s/DB_DATABASE=.*/DB_DATABASE=$DB_NAME/" /var/www/html/myapp/.env
sed -i "s/DB_USERNAME=.*/DB_USERNAME=$DB_USER/" /var/www/html/myapp/.env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=$DB_PASSWORD/" /var/www/html/myapp/.env

# Enable Apache modules
sudo a2enmod rewrite
sudo systemctl restart apache2

# End of script

