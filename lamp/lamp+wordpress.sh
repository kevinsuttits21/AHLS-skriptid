#!/bin/bash

# antud skript on LAMP skript + wordpress

apt update # igaks juhuks apt update teeb

# APACHE2 PAIGALDUS

if   apt list --installed "apache2" 2>/dev/null | grep -q "apache2" > /dev/null 2>&1; then
     echo "Teenus on juba olemas süsteemis!"
     systemctl status apache2
else
     echo "Teenus ei ole olemas süsteemis!"
     echo "Alustan paigaldamist..."
     apt update
     apt install -y apache2
fi


# MYSQL PAIGALDUS

if apt list --installed "mysql-server" 2>/dev/null | grep -q "mysql-server" > /dev/null 2>&1; then
     echo "Teenus on juba olemas susteemis. Lisaks on olemas ka teised abipaketid!"
     systemctl status mysql
else
    echo "Teenus ei ole olemas susteemis!"
    echo "Alustan paigaldamist..."
    apt update
    apt install wget -y
    wget https://dev.mysql.com/get/mysql-apt-config_0.8.28-1_all.deb
    apt install ./mysql-apt-config_*_all.deb
    apt update
    apt install mysql-server
    systemctl enable --now mysql
    mysql --version
fi

# PHP PAIGALDUS

if php -v  > /dev/null 2>&1; then
     echo "Teenus on juba olemas süsteemis. Lisaks on olemas ka teised abipaketid!"
     php -v
else
    echo "Teenus ei ole olemas süsteemis!"
    echo "Alustan paigaldamist..."
    apt update
    apt install -y php
fi


# PHPMYADMIN PAIGALDUS


if dpkg -l | grep -q phpmyadmin; then
       echo "Teenus on juba olemas süsteemis!"
else
       echo "Teenus ei ole olemas süsteemis!"
       echo "Alustan paigaldamist..."
       apt update
       apt install phpmyadmin
fi

# WORDPRESS PAIGALDUS


wordpress_dir="/var/www/html/wordpress"

if [ -d "$wordpress_dir" ]; then # kas on olemas
    echo "Wordpress on juba paigaldatud!"
    exit # lahkume siis
else

# kusime MySQL root kasutaja parooli
echo "MySQL root kasutaja parool: "
read -s mysql_pass # turvalisuse mottes rakendatakse siin silent modeis kirjutamine
# loome andmebaasi, kasutaja koos parooliga ja anname talle õigusi

echo "Luuakse andmebaas wpdatabase, kasutaja wpuser parooliga BarackObama12"
mysql --user="root" --password=${mysql_pass} --execute="create database wpdatabase;
CREATE USER wpuser@localhost IDENTIFIED BY 'BarackObama12';
GRANT ALL PRIVILEGES ON wpdatabase.* to wpuser@localhost;
FLUSH PRIVILEGES;
EXIT"
# lahkume mysql line-ist

# laeme wordpressi alla ja pakime selle lahti

echo "Paigaldan Wordpressi..."
wget -P /var/www/html https://wordpress.org/latest.tar.gz # laeme alla internetist kokku pakitud faili
tar xvzf /var/www/html/latest.tar.gz -C /var/www/html
rm /var/www/html/latest.tar.gz # eemaldame kokku pakitud fail
chown -R www-data:www-data /var/www/html/wordpress # anname õigusid www-data-le

# kopeerime sample konfiguratsioonifaili ja selle abil teeme teise conf faili (mida hakkame kasutama)

cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

# konfigureerime andmebaasi

echo "Konfigureerin andmebaasi..."

sed -i "s/database_name_here/wpdatabase/g" /var/www/html/wordpress/wp-config.php
echo "Valiti andmebaasiks wpdatabase"
sed -i "s/username_here/wpuser/g" /var/www/html/wordpress/wp-config.php
echo "Valiti kasutaja nimeks wpuser"
sed -i "s/password_here/BarackObama12/g" /var/www/html/wordpress/wp-config.php
echo "Valiti kasutaja parooliks seda, mida ennem valiti"

# muudame Wordpressi lehe kataloogi Apache2 peamiseks kataloogiks

echo "Muudan Wordpress lehe kataloogi Apache2 peamiseks kataloogiks..."

sed -i 's/\/var\/www\/html/\/var\/www\/html\/wordpress/g' /etc/apache2/sites-available/000-default.conf

systemctl restart apache2 # taaskaivitame Apache2 teenuse, et muudatused tekiksid

echo "Wordpress sai edukalt paigaldatud!"
echo "Wordpress on kättesaadav, kui liigute brauserisse ja kirjutate otsingusse localhost voi oma masina IP aadress."

fi

# DONE
