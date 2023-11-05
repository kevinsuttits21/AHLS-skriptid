#!/bin/bash

# rangelt soovitatud kaivitada root kasutajana
# antud skript kontrollib, kas mysql-server on paigaldatud susteemi ja kui on siis teavitab sellest, mu>
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
