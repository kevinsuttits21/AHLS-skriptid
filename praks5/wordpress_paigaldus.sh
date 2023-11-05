#!/bin/bash
 
# rangelt soovitatud käivitada root kasutajana
# antud skript kontrollib, kas wordpress on paigaldatud süsteemi ja kui on, siis teavitab sellest, muidu paigaldab selle
 
wordpress_dir="/var/www/html/wordpress"
 
if [ -d "$wordpress_dir" ]; then # kas on olemas
    echo "Wordpress on juba paigaldatud!"
    exit # lahkume siis
else
 
# kusime wp root parooli
echo "WP root kasutaja parool: "
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
# skript loppeb
