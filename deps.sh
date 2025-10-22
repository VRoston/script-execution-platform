apt-get update
apt-get install build-essential -y
apt-get install apache2 -y
rm /var/www/html/index.html
ln -s /vagrant/index.html /var/www/html/index.html
systemctl reload apache2
apt-get install mysql-server -y
systemctl start mysql.service
# sudo mysql
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
# exit
# mysql_secure_installation
systemctl restart mysql
