#!/usr/bin/bash
export PATH="/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin"
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG="$SCRIPT_DIR/backup.log"

echo "--- Daily Backup started at $(date) ---" >> "$LOG"

if [ -z "$1" ]; then
    echo "[Error] there is no database given" >> "$LOG"
    exit 1
fi

user=$(whoami)
database="$1"
BACKUP_PATH="$SCRIPT_DIR/backup"

if [ ! -d "$BACKUP_PATH" ]; then
    mkdir "$BAKCUP_PATH"
    echo "[INFO] Created bakcup path: ${BACKUP_PATH}" >> "$LOG"
fi

cd "$BACKUP_PATH" || exit 1

GIT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$GIT_PATH" || exit 1

if [ ! -d ".git" ]; then
    echo "[INFO] Initializing Git repository..." >> "$LOG"
    git init >> "$LOG" 2>&1
    git remote add origin https://github.com/backupgitSO/backupSistemas.git >> "$LOG" 2>&1
    git branch -M main >> "$LOG" 2>&1
    git pull origin main >> "$LOG" 2>&1
    echo "Git repository syncronized" >> "$LOG"
fi

backup_date=$(date +%Y-%m-%d)
backup_file="${BACKUP_PATH}/backup_${backup_date}_${database}.sql"

mariadb-dump -u root -p'1124' "$database" > "$backup_file"
echo "Backup created at $GIT_PATH" >> "$LOG"

git add "$backup_file" >> "$LOG" 2>&1
git commit -m "BACKUP of ${database} on ${backup_date}" >> "$LOG" 2>&1
git push origin main >> "$LOG" 2>&1

echo "[SUCCESS] Backup completed successfully" >> "$LOG"
