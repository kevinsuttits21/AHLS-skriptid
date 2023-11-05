#!/bin/bash

# rangelt soovitatud käivitada root kasutajana
# kontrollime, kas apache2 on süsteemis olemas ja kui ei ole, siis paigaldame, muidu anname teada,

if   apt list --installed "apache2" 2>/dev/null | grep -q "apache2" > /dev/null 2>&1; then
     echo "Teenus on juba olemas süsteemis!"
     systemctl status apache2
else
     echo "Teenus ei ole olemas süsteemis!"
     echo "Alustan paigaldamist..."
     apt update
     apt install -y apache2
fi
