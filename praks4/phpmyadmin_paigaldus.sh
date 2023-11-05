#!/bin/bash
# rangelt soovitatav käivitada skripti root kasutajana
# antud skript kontrollib, kas phpadmin on olemas süsteemis ja kui on, siis teavitab sellest, muidu paigaldab
if dpkg -l | grep -q phpmyadmin; then
       echo "Teenus on juba olemas süsteemis!"
else
       echo "Teenus ei ole olemas süsteemis!"
       echo "Alustan paigaldamist..."
       apt update
       apt install phpmyadmin
fi
