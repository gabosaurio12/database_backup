#!/bin/bash
export PATH"/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin"

user=$(whoami)

crontab -l 2>/dev/null > crontab_new
echo "0 21 * * * /home/${user}/SistemasOperativos/backup_predeterminado.sh sistemasOp" >> crontab_new
crontab crontab_new
rm crontab_new
