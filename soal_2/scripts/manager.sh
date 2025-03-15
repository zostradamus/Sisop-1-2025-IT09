#!/bin/bash
CRON_FILE="/tmp/crontab_backup"

echo "Crontab Manager"
while true; do
    echo "1) Add CPU Monitoring"
    echo "2) Remove CPU Monitoring"
    echo "3) Add RAM Monitoring"
    echo "4) Remove RAM Monitoring"
    echo "5) View Active Jobs"
    echo "6) Exit"
    read -p "Choose an option: " option
    
    crontab -l > "$CRON_FILE" 2>/dev/null
    case "$option" in
        1)
            echo "*/5 * * * * $(pwd)/scripts/core_monitor.sh" >> "$CRON_FILE"
            crontab "$CRON_FILE"
            echo "CPU monitoring added."
            ;;
        2)
            sed -i "/core_monitor.sh/d" "$CRON_FILE"
            crontab "$CRON_FILE"
            echo "CPU monitoring removed."
            ;;
        3)
            echo "*/5 * * * * $(pwd)/scripts/frag_monitor.sh" >> "$CRON_FILE"
            crontab "$CRON_FILE"
            echo "RAM monitoring added."
            ;;
        4)
            sed -i "/frag_monitor.sh/d" "$CRON_FILE"
            crontab "$CRON_FILE"
            echo "RAM monitoring removed."
            ;;
        5)
            crontab -l
            ;;
        6)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done
