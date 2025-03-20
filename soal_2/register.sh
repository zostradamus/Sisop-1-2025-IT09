#!/bin/bash

# Path ke database
DB_FILE="/data/player.csv"
SALT="mysecretsalt"

# Cek & buat folder /data jika belum ada
if [ ! -d "/data" ]; then
    mkdir -p "/data"
fi

# Cek & buat file player.csv jika belum ada
if [ ! -f "$DB_FILE" ]; then
    touch "$DB_FILE"
    chmod 666 "$DB_FILE"
fi

echo "=== REGISTER PLAYER ==="
read -p "Masukkan Email: " email
read -p "Masukkan Username: " username
read -s -p "Masukkan Password: " password
echo ""

# Validasi email
if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Email tidak valid!"
    exit 1
fi

# Validasi password
if ! [[ "$password" =~ [A-Z] && "$password" =~ [a-z] && "$password" =~ [0-9] && ${#password} -ge 8 ]]; then
    echo "Password harus minimal 8 karakter, mengandung huruf besar, huruf kecil, dan angka."
    exit 1
fi

# Cek apakah email sudah ada di database
if grep -q "^$email," "$DB_FILE"; then
    echo "Email sudah terdaftar!"
    exit 1
fi

# Hash password dengan SHA-256 + salt
hashed_password=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')

# Simpan ke database
echo "$email,$username,$hashed_password" >> "$DB_FILE"

echo "Registrasi berhasil!"
