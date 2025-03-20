#!/bin/bash

# Path ke database
DB_FILE="/data/player.csv"
SALT="mysecretsalt"

echo "=== LOGIN PLAYER ==="
read -p "Masukkan Email: " email
read -s -p "Masukkan Password: " password
echo ""

# Hash password yang dimasukkan
hashed_input=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')

# Cek email dan password di database
if grep -q "^$email,.*,$hashed_input$" "$DB_FILE"; then
    echo "Login berhasil! Selamat datang!"
else
    echo "Login gagal! Email atau password salah."
fi

