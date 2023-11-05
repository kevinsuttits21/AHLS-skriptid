#!/bin/bash
 
# rangelt soovitatud kaivitada root kasutajana
# kontrollime, kas php teenus koos vajalikke abipakettidega on olemas süsteemis ja kui on, siis teavitame
 
if php -v  > /dev/null 2>&1; then
     echo "Teenus on juba olemas süsteemis. Lisaks on olemas ka teised abipaketid!"
     php -v
else
    echo "Teenus ei ole olemas süsteemis!"
    echo "Alustan paigaldamist..."
    apt update
    apt install -y php
fi
