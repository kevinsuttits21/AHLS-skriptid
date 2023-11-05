# AHLS-skriptid
Aine haldustegevuste automatiseerimine tunniülesanded. Täpsemalt BASH ja Ansible .yml failid.
# Kuidas BASH skripte käivitada?
Skripte saad käivitada näiteks nii, et kopeerid skripti sisu oma Linux masinas oleva teksti faili sisse (nt skript.sh) ja kirjutad näiteks sellist käsku terminalis:
```
/home/skriptkevin/skriptid/skript.sh
```
Käsus on mainitud põhimõtteliselt terve asukoht, kus skript asub. Kui seda käsku kasutada, siis on skript käivitatud.

Saab ka teha nii, et laed skriptid ise alla oma Linux masinasse ja siis käivitad oma valikul skripti/skripte.

Võimalik on ka nii, et oma tehtud faili või alla laetud faili ei saa kasutada, seega pead sisestama järgmist käsku, et käivitamisõigusi anda endale:
```
chmod u+x (skripti täisasukoht või kui oled seal kataloogis juba, siis ainult skripti nimi)
```
# Kuidas kasutada .yml faile Playbook'idena tarkvaras Ansible?
Tugi jaoks on olemas Ansible tarkvaraarendajate poolt loodud dokumentatsioon siin: https://docs.ansible.com/ansible/latest/network/getting_started/first_playbook.html

Seal samas lingis on ka leitav, kuidas paigaldada Ansible server.
# Windows tugi?
Windowsis on võimalik bash scripte käivitada WSL-i abil.

Samuti on võimalik ka kasutada Playbook'e Windows seadmete vastu kasutades tarkvara Ansible. Selle jaoks on dokumentatsioon loodud siin: https://docs.ansible.com/ansible/latest/os_guide/windows_usage.html


Siin saad abi sellega, kuidas  installeerida WSL-i oma Windows masinale: https://github.com/MicrosoftDocs/wsl/blob/main/WSL/install-manual.md

# Hetkesed tingimused
* Playbook'id on testitud vaid **Debian 11** klientmasinatel.
* Ansible-server oli installeeritud **Debian 12** masinal.
* Klientmasinatel peab olema loodud kasutaja **`kasutaja`**.
* Rooti kasutaja parooliks seadistatakse skriptides/playbook'ides **`BarackObama12`**.
* Kõik skriptid ja playbook'id käivita **`root`** kasutajas!

# Praktikumid (.sh kui ka .yml failid)
### praks1
* [__apache2.yml__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks1/apache2.yml) - Ansible jaoks .yml fail, mis paigaldab klientarvutisse Apache2 teenuse kui ka lubab ja paneb käsitlusse userdir mooduli
* [__apache2_paigaldus.sh__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks1/apache2_paigaldus.sh) - Bash skript, mis paigaldab klientarvutisse Apache2 teenuse

### praks2
* [__php.yml__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks2/php.yml) - Ansible jaoks .yml fail, mis paigaldab klientarvutisse PHP teenuse
* [__php_paigaldus.sh__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks2/php_paigaldus.sh) - Bash skript, mis paigaldab klientarvutisse PHP

### praks3
* [__mysql-server.yml__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks3/mysql-server.yml) - Ansible jaoks .yml fail, mis paigaldab klientarvutisse MySQL-Server teenuse
* [__mysql-server_paigaldus.sh__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks3/mysql-server_paigaldus.sh) - Bash skript, mis paigaldab klientarvutisse MySQL-Server teenuse

### praks4
* [__phpmyadmin.yml__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks4/phpmyadmin.yml) - Ansible jaoks .yml fail, mis paigaldab klientarvutisse phpMyAdmin teenuse
* [__phpmyadmin_paigaldus.sh__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks4/phpmyadmin_paigaldus.sh) - Bash skript, mis paigaldab klientarvutisse phpMyAdmin teenuse

### praks5
* [__wordpress.yml__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks5/wordpress.yml) - Ansible jaoks .yml fail, mis paigaldab klientarvutisse Wordpress teenuse
* [__wordpress_paigaldus.sh__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/praks5/wordpress_paigaldus.sh) - Bash skript, mis paigaldab klientarvutisse Wordpress teenuse

### lamp
* [__lamp+wordpress.sh__](https://github.com/kevinsuttits21/AHLS-skriptid/blob/main/lamp/lamp%2Bwordpress.sh) - Bash skript, mis paigaldab klientarvutisse kõik LAMP teenused kui ka Wordpress
