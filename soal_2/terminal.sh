#!/bin/bash

while true; do
    echo "=== Sistem Monitoring Arcaea ==="
    echo "1. Register"
    echo "2. Login"
    echo "3. Crontab Manager"
    echo "4. Keluar"
    read -p "Pilih menu: " choice

    case $choice in
        1)
            ./register.sh
            ;;
        2)
            ./login.sh
            ;;
        3)
            ./scripts/manager.sh
            ;;
        4)
            echo "Keluar dari sistem."
            exit 0
 ;;
        *)
            echo "Pilihan tidak valid!"
            ;;
    esac
done
