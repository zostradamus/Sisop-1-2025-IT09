#!/bin/bash

# Lokasi file log
LOG_FILE="./log/fragment.log"

# Ambil waktu sekarang
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Ambil total RAM (dalam KB)
RAM_TOTAL=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')

# Ambil RAM yang tersedia (dalam KB)
RAM_AVAILABLE=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')

# Hitung RAM yang sedang digunakan
RAM_USED=$((RAM_TOTAL - RAM_AVAILABLE))

# Hitung persentase penggunaan RAM
RAM_PERCENTAGE=$((RAM_USED * 100 / RAM_TOTAL))

# Simpan ke dalam file log
echo "$TIMESTAMP - RAM Usage: $RAM_PERCENTAGE% - Used: $RAM_USED KB / Total: $RAM_TOTAL KB" >> "$LOG_FILE"
