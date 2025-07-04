#!/usr/bin/bash
export PATH="/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin"
set -e

log="/home/$(whoami)/cron_backup.log"
echo "---- $(date) ----" >> "$log"

if [ -z "$1" ]; then
    echo "Error: No hay base de datos como argumento" >> "$log"
    exit 1
fi

user=$(whoami)
current_route=$(pwd)
database="$1"
backup_route="/home/${user}/backup"

if [ ! -d "$backup_route" ]; then
    mkdir "$backup_route"
    echo "Ruta: ${backup_route} creada"
fi

cd "$backup_route" || exit 1

if [ ! -d ".git" ]; then
    git init >> "$log" 2>&1
    git remote add origin https://github.com/backupgitSO/backupSistemas.git
    git branch -M main >> "$log" 2>&1
    git pull origin main >> "$log" 2>&1
    echo "Repositorio en git sincronizado" >> "$log"
fi

backup_date=$(date +%Y-%m-%d)
backup_file="${backup_route}/backup_${backup_date}_${database}.sql"
echo "pre dump" >> "$log"
mariadb-dump -u root -p'1124' "$database" > "$backup_file"
echo "post dump" >> "$log"
echo "Backup creado en /home/${user}/backup" >> "$log"

git add "$backup_file" >> "$log" 2>&1
git commit -m "BACKUP a ${database} el ${backup_date}" >> "$log" 2>&1
git push origin main >> "$log" 2>&1

echo "Backup exitoso: $backup_file" >> "$log"
