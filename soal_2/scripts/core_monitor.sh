#!/bin/bash

# Lokasi file log
LOG_FILE="./log/core.log"

# Ambil waktu sekarang
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Ambil penggunaan CPU dalam persen
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Ambil model CPU
CPU_MODEL=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)

# Simpan ke dalam file log
echo "$TIMESTAMP - Core Usage: $CPU_USAGE% - CPU Model: $CPU_MODEL" >> "$LOG_FILE"
