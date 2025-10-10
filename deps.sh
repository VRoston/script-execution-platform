apt update
apt install apache
apt install mysql-server -y
systemctl enable --now mysql
mysql_secure_installation
systemctl restart mysql