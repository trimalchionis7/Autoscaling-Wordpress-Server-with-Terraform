# Preinstallations

# Update all packages on the system to their latest versions
sudo yum update -y
# Install Apache web server
sudo yum install -y httpd
# Install MariaDB (version 10.5), PHP, and PHP's MySQL extension, along with unzip utility
sudo yum install -y mariadb105-server php php-mysqlnd unzip

# Start the Apache server and enable it to start automatically on system boot
sudo systemctl start httpd
sudo systemctl enable httpd

# Start the MariaDB service and enable it to start automatically on system boot
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure MySQL installation (set root password, remove anonymous users, disallow remote root login, remove test database)
sudo mysql_secure_installation

# Set the root password for MySQL
sudo mysqladmin -u root password 'rootpassword'

# Create a MySQL database and user for your application
sudo mysql -u root -p<<MYSQL_SCRIPT
CREATE DATABASE mysql-database;
CREATE USER 'username'@'localhost' IDENTIFIED BY 'rootpassword';
GRANT ALL PRIVILEGES ON mysql-database.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Download the latest version of WordPress and place it in the web root directory
wget http://wordpress.org/latest.tar.gz -P /var/www/html
cd /var/www/html
tar -zxvf latest.tar.gz # Extract the WordPress archive
cp -rvf wordpress/* . # Copy WordPress files to the current directory
rm -R wordpress # Remove the now-empty WordPress directory
rm latest.tar.gz # Clean up by deleting the downloaded archive

# Rename the sample WordPress configuration file and update it with the database details
cp ./wp-config-sample.php ./wp-config.php
sed -i "s/'database_name_here'/'mysql-database'/g" wp-config.php
sed -i "s/'username_here'/'username'/g" wp-config.php
sed -i "s/'password_here'/'rootpassword'/g" wp-config.php

# Change the ownership and permissions to secure the WordPress files and directories
usermod -a -G apache ec2-user # Add the ec2-user to the apache group
chown -R ec2-user:apache /var/www # Change owner to ec2-user and group to apache
chmod 2775 /var/www # Set the directory permissions
find /var/www -type d -exec chmod 2775 {} \; # Find directories and set permissions
find /var/www -type f -exec chmod 0664 {} \; # Find files and set permissions

# Set up the WordPress database and user
echo "CREATE DATABASE mysql-database;" >> /tmp/db.setup
echo "CREATE USER 'username'@'localhost' IDENTIFIED BY 'rootpassword';" >> /tmp/db.setup
echo "GRANT ALL ON mysql-database.* TO 'username'@'localhost';" >> /tmp/db.setup
echo "FLUSH PRIVILEGES;" >> /tmp/db.setup
mysql -u root --password='rootpassword' < /tmp/db.setup # Apply the database setup
sudo rm /tmp/db.setup # Clean up the temporary setup file
