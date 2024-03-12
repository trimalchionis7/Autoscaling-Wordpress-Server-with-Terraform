# Wordpress installation and connection to AWS RDS database

# Update all packages on the system to their latest versions
sudo yum update -y
# Install Apache web server
sudo yum install -y httpd
# Install PHP and PHP's MySQL extension, along with unzip utility
sudo yum install -y php php-mysqlnd unzip

# Set variables for the database configuration
DBName='jonnierds'
DBUser='rdsusername'
DBPassword='rdspassword'
DBRootPassword='rootpassword'
DBHostname='jonnie-rds.c9eymqyc04g3.us-west-2.rds.amazonaws.com'

# Start the Apache server and enable it to start automatically on system boot
sudo systemctl start httpd
sudo systemctl enable httpd

# Download the latest version of WordPress and place it in the web root directory
wget http://wordpress.org/latest.tar.gz -P /var/www/html
cd /var/www/html
tar -zxvf latest.tar.gz # Extract the WordPress archive
cp -rvf wordpress/* . # Copy WordPress files to the current directory
rm -R wordpress # Remove the now empty WordPress directory
rm latest.tar.gz # Clean up by deleting the downloaded archive

# Rename the sample WordPress configuration file and update it with the database details
cp ./wp-config-sample.php ./wp-config.php
sed -i "s/'database_name_here'/$DBName/g" wp-config.php
sed -i "s/'username_here'/$DBUser/g" wp-config.php
sed -i "s/'password_here'/$DBPassword/g" wp-config.php
sed -i "s/'localhost'/$DBHostname/g" wp-config.php

# Change the ownership and permissions to secure the WordPress files and directories
usermod -a -G apache ec2-user # Add the ec2-user to the apache group
chown -R ec2-user:apache /var/www # Change owner to ec2-user and group to apache
chmod 2775 /var/www # Set the directory permissions
find /var/www -type d -exec chmod 2775 {} \; # Find directories and set permissions
find /var/www -type f -exec chmod 0664 {} \; # Find files and set permissions

# Set up the WordPress database and user
# echo "CREATE DATABASE $DBName;" >> /tmp/db.setup
# echo "CREATE USER '$DBUser'@'%' IDENTIFIED BY '$DBPassword';" >> /tmp/db.setup
# echo "GRANT ALL ON $DBName.* TO '$DBUser'@'%';" >> /tmp/db.setup
# echo "FLUSH PRIVILEGES;" >> /tmp/db.setup

# Apply the database setup
sudo mysqladmin -u root password $DBRootPassword
sudo mysql -h $DBHostname -u $DBUser -p $DBPassword -e "SHOW DATABASES";
