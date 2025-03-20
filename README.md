# LAPORAN RESMI SOAL MODUL 1 SISOP

## ANGGOTA KELOMPOK
| Nama                           | NRP        |
| -------------------------------| ---------- |
| Shinta Alya Ramadani           | 5027241016 |
| Prabaswara Febrian Winandika   | 5027241069 |
| Muhammad Farrel Rafli Al Fasya | 5027241075 |
### SOAL 1
# Analisis Data Membaca dengan AWK

Repositori ini berisi skrip AWK untuk menganalisis data membaca dari `reading_data.csv`. Setiap skrip mengambil wawasan tertentu dari dataset.

## Penjelasan Skrip AWK

### 1. Menghitung Jumlah Buku yang Dibaca oleh Chris Hemsworth
**Perintah:**
```sh
awk -F ',' '$2 == "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca", count, "buku."}' reading_data.csv
```
**Cara kerja:**
- Memeriksa apakah kolom ke-2 berisi "Chris Hemsworth".
- Menambah `count` setiap kali kondisi terpenuhi.
- Mencetak jumlah total buku yang dibaca oleh Chris Hemsworth.
- **Contoh Output:** Jika Chris Hemsworth muncul dalam 2 baris, hasilnya adalah `Chris Hemsworth membaca 2 buku.`

### 2. Menghitung Rata-rata Durasi Membaca dengan Tablet
**Perintah:**
```sh
awk -F ',' '$8 == "Tablet" {total += $6; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah", total / count, "menit."; else print "Tidak ada data untuk Tablet."}' reading_data.csv
```
**Cara kerja:**
- Memfilter baris yang memiliki "Tablet" di kolom ke-8.
- Menjumlahkan durasi membaca dari kolom ke-6 dan menghitung jumlahnya.
- Menghitung rata-rata (`total / count`) dan mencetak hasilnya.
- **Contoh Output:** Jika durasi adalah 30 dan 60 menit, hasilnya `Rata-rata durasi membaca dengan Tablet adalah 45 menit.`

### 3. Menemukan Pembaca dengan Rating Tertinggi
**Perintah:**
```sh
awk -F ',' 'NR == 1 {next} {if ($7 > max) {max = $7; name = $2; title = $3}} END {print "Pembaca dengan rating tertinggi:", name, "-", title, "-", max}' reading_data.csv
```
**Cara kerja:**
- Melewati baris pertama (header).
- Menyimpan rating tertinggi dari kolom ke-7 serta nama pembaca (kolom ke-2) dan judul buku (kolom ke-3).
- **Contoh Output:** Jika "John Doe" membaca "Book A" dengan rating 4.9, hasilnya `Pembaca dengan rating tertinggi: John Doe - Book A - 4.9`.

### 4. Menentukan Genre Buku Paling Populer di Asia Setelah 2023
**Perintah:**
```sh
awk -F',' 'NR > 1 {
    tanggal = $5
    region = tolower($9)
    genre_buku = $4

    if (tanggal > "2023-12-31" && region ~ /asia/) {
        genre_count[genre_buku]++
    }
}

END {
    max = 0
    populer = "Tidak ada data"

    for (g in genre_count) {
        if (genre_count[g] > max) {
            max = genre_count[g]
            populer = g
        }
    }

    if (max > 0) {
        print "Genre paling populer di Asia setelah 2023 adalah", populer, "dengan", max, "buku.";
    } else {
        print "Tidak ada data yang cocok untuk Asia setelah 2023.";
    }
}' reading_data.csv
```
**Cara kerja:**
- Mengambil tanggal (kolom ke-5), region (kolom ke-9, diubah ke huruf kecil), dan genre buku (kolom ke-4).
- Memeriksa apakah tanggal lebih dari "2023-12-31" dan region mengandung "Asia".
- Menghitung jumlah buku untuk setiap genre yang memenuhi kriteria.
- **Contoh Output:** Jika "Fiction" muncul 3 kali, hasilnya `Genre paling populer di Asia setelah 2023 adalah Fiction dengan 3 buku.`

## Cara Menjalankan Skrip
Pastikan file `reading_data.csv` tersedia, lalu jalankan perintah berikut di terminal:

```sh
bashpoppo_siroyo.sh
```
```sh
./poppo_siroyo.sh
```
Atau jalankan perintah secara terpisah sesuai kebutuhan.

---
Dibuat untuk menganalisis kebiasaan membaca menggunakan AWK.


### SOAL 2
# Sistem Manajemen Pengguna dan Monitoring dengan Bash

Repositori ini berisi skrip Bash untuk manajemen pengguna (registrasi dan login), monitoring CPU dan RAM, serta terminal interaktif untuk menjalankan berbagai fungsi.

## Penjelasan Skrip

### 1. **Register (register.sh)**
**Tujuan:**
- Mendaftarkan pengguna dengan email, username, dan password.
- Memvalidasi format email.
- Memastikan password minimal 8 karakter, memiliki huruf besar, kecil, dan angka.
- Menyimpan data pengguna dalam file `player.csv` dengan password yang di-hash menggunakan SHA-256 dan salt.

### 2. **Login (login.sh)**
**Tujuan:**
- Memverifikasi login pengguna dengan mencocokkan email dan password yang di-hash.
- Jika valid, menampilkan pesan sukses login.
- Jika tidak valid, menampilkan pesan gagal login.

### 3. **Monitoring CPU & RAM (manager.sh)**
**Tujuan:**
- **Monitor CPU:**
  - Mengambil penggunaan CPU saat ini dan menyimpannya ke `core.log`.
- **Monitor RAM:**
  - Mengambil total, digunakan, dan tersedia RAM lalu menyimpannya ke `fragment.log`.
- **Crontab Manager:**
  - Menambahkan atau menghapus job crontab untuk pemantauan CPU dan RAM secara otomatis setiap menit.
  
### 4. **Analisis Data Membaca (script.sh)**
**Tujuan:**
- Menghitung jumlah buku yang dibaca oleh Chris Hemsworth.
- Menghitung rata-rata durasi membaca dengan Tablet.
- Menemukan pembaca dengan rating tertinggi.
- Menentukan genre buku paling populer di Asia setelah 2023.

### 5. **Terminal Interaktif (terminal.sh)**
**Tujuan:**
- Menyediakan antarmuka menu untuk menjalankan:
  1. Registrasi pengguna (`register.sh`).
  2. Login pengguna (`login.sh`).
  3. Crontab Manager (`manager.sh`).
  4. Keluar dari sistem.

## Cara Menjalankan Skrip

1. **Pastikan semua skrip memiliki izin eksekusi:**
   ```sh
   chmod +x register.sh login.sh manager.sh terminal.sh
   ```

2. **Jalankan terminal interaktif:**
   ```sh
   ./terminal.sh
   ```
   Ikuti petunjuk yang muncul di layar untuk memilih menu.

3. **Menjalankan monitoring secara manual:**
   ```sh
   ./manager.sh cpu  # Untuk memantau CPU
   ./manager.sh ram  # Untuk memantau RAM
   ./manager.sh manager  # Untuk mengelola crontab
   ```

---
Dibuat untuk sistem manajemen pengguna dan monitoring server dengan Bash.


### SOAL 3
#### Analisis Soal
Dalam membuat soal ini, skrip dibuat menggunakan beberapa perintah sistem seperti curl, jq, figlet, toilet, dan ps untuk menampilkan informasi dan efek visual dalam terminal sesuai kebutuhan dari tiap-tiap sub-soal.
#### Analisis Kode
##### Pembersihan Layar Awal
```sh
clear
```
Sebelum menjalankan skrip, terminal akan dibersihkan untuk memberikan tampilan yang rapi.
##### Fungsi speak_to_me
```sh
speak_to_me() {
    while true; do
        curl -s https://www.affirmations.dev | jq -r '.affirmation'
        sleep 1
    done
}
```
Fungsi ini menampilkan afirmasi positif dari API eksternal (https://www.affirmations.dev) setiap detik dengan menggunakan curl dan memprosesnya dengan jq.
Output :
![image](https://github.com/user-attachments/assets/2afaf298-bb7d-481b-a9fb-bb1ec43e20c5)

##### Fungsi on_the_run
```sh
on_the_run() {
    local term_width=$(tput cols)  
    local progress=0
    local bar_size=$((term_width - 15))
```
Fungsi ini menampilkan progress bar animasi dengan nilai progres yang diperbarui secara acak.
Output :
![image](https://github.com/user-attachments/assets/92499869-c0f3-421f-bd96-ec1b0224d227)

###### Fungsi time_display
```sh
time_display() {
    while true; do
        clear
        if command -v figlet &> /dev/null; then
            figlet -c "TIME"
        elif command -v toilet &> /dev/null; then
            toilet -f bigmono12 "TIME"
        else
            echo -e "\n===== TIME =====\n"
        fi
        echo "$(date '+%A, %d %B %Y - %H:%M:%S')"
        sleep 1
    done
}
```
Fungsi ini menampilkan waktu real-time dan menggunakan figlet atau toilet untuk mempercantik tampilan.
Output :
![image](https://github.com/user-attachments/assets/a35bce88-ab14-47a5-98dc-7f70f26a4f33)

###### Fungsi money_display
```sh
money_display() {
    symbols=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")
    cols=$(tput cols)
    lines=$(tput lines)
    while true; do
        clear
        for ((i=0; i<lines; i++)); do
            for ((j=0; j<cols; j++)); do
                if (( RANDOM % 5 == 0 )); then
                    printf "\033[32m%s" "${symbols[RANDOM % ${#symbols[@]}]}"
                else
                    printf " "
                fi
            done
            echo ""
        done
        sleep 0.05
    done
}
```
Fungsi ini membuat efek "hujan" simbol mata uang di terminal dengan warna hijau.
Output :
![image](https://github.com/user-attachments/assets/5a376d35-b30a-4a47-82f7-a13302a50c0b)

##### Fungsi brain_damage
```sh
brain_damage() {
    while true; do
        clear
        if command -v figlet &> /dev/null; then
            figlet -c "BRAIN DAMAGE"
        elif command -v toilet &> /dev/null; then
            toilet -f bigmono12 "BRAIN DAMAGE"
        else
            echo -e "\n===== BRAIN DAMAGE =====\n"
        fi
        echo "---------------------------------"
        echo "PID       COMMAND       %CPU      %MEM"
        echo "---------------------------------"
        ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -10
        sleep 1
    done
}
```
Fungsi ini berfungsi sebagai task manager sederhana, menampilkan daftar proses dengan penggunaan CPU tertinggi.
Output :
![image](https://github.com/user-attachments/assets/48a811cf-4fcb-40c9-b235-fc9d8c441ec1)

##### Pemrosesan Argumen Input
```sh
if [[ "$1" == "--play="* ]]; then
    track="${1#--play=}"
    case "$track" in
        "speak to me") speak_to_me ;;
        "on the run") on_the_run ;;
        "time") time_display ;;
        "money") money_display ;;
        "brain damage") brain_damage ;;
        *) echo "Error: Lagu tidak dikenali!" ;;
    esac
else
    echo "Usage: ./dsotm.sh --play=\"<Track>\""
    echo "Tracks: speak to me, on the run, time, money, brain damage"
fi
```
Skrip ini membaca argumen input untuk mengeksekusi fungsi yang sesuai dengan perintah --play="<Track>".
### SOAL 4
SOON
