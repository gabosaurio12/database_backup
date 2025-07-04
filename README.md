# Database Automatic Backup Generator
Bash scripts to automate daily backups of a MySQL/MariaDB database using `mysqldump`, scheduled at a specific time.

## Features
- Automated databases backup
- Easy setup with `cron`
- Customizable backup time

## Technologies
- Bash (`#!/bin/bash`)
- `cron` (Crontab)
- `mysqldump` / `mariadb-dump`

## How to run

1. Clone the repository:
 ```bash
   git clone https://github.com/gabosaurio12/database_backup.git
   cd database_backup
```
2.Grant execute permissions to the scripts
```
  chmod +x ./scripts/crontab_config.sh
  chmod +x ./scripts/daily_backup.sh
```
3. Run the configuration script
```bash
  ./scripts/crontab_config.sh
```

## Author
Gabriel Antonio González López - [@gabosaurio12](https://github.com/gabosaurio12)
