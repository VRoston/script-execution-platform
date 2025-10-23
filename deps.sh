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
apt-get install python3-pip -y
apt-get install python3.10-venv -y
python3 -m venv .venv
source .venv/bin/activate
pip install -r /vagrant/requirements.txt
# mkdir /vagrant/logs || true
cd /vagrant
nohup python3 /vagrant/server.py --host=0.0.0.0 > /vagrant/logs/app.log 2>&1 &

