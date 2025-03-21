# LAPORAN RESMI SOAL MODUL 1 SISOP

## ANGGOTA KELOMPOK
| Nama                           | NRP        |
| -------------------------------| ---------- |
| Shinta Alya Ramadani           | 5027241016 |
| Prabaswara Febrian Winandika   | 5027241069 |
| Muhammad Farrel Rafli Al Fasya | 5027241075 |
### SOAL 1
# Analisis Data Membaca dengan AWK

Skrip `poppo_siroyo.sh` digunakan untuk menganalisis data membaca dari `reading_data.csv` menggunakan perintah AWK. Berikut adalah fungsi dari masing-masing bagian skrip.

## Penjelasan Skrip AWK

### 1. Menghitung Jumlah Buku yang Dibaca oleh Chris Hemsworth
**Perintah:**
```sh
awk -F ',' '$2 == "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca", count, "buku."}' reading_data.csv
```
**Cara kerja:**
- Mengecek apakah kolom ke-2 berisi "Chris Hemsworth".
- Menambah `count` setiap kali kondisi terpenuhi.
- Mencetak jumlah total buku yang dibaca oleh Chris Hemsworth.

**Contoh Output:**
```
Chris Hemsworth membaca 5 buku.
```

### 2. Menghitung Rata-rata Durasi Membaca dengan Tablet
**Perintah:**
```sh
awk -F ',' '$8 == "Tablet" {total += $6; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah", total / count, "menit."; else print "Tidak ada data untuk Tablet."}' reading_data.csv
```
**Cara kerja:**
- Memfilter baris yang memiliki "Tablet" di kolom ke-8.
- Menjumlahkan durasi membaca dari kolom ke-6 dan menghitung jumlahnya.
- Menghitung rata-rata (`total / count`) dan mencetak hasilnya.

**Contoh Output:**
```
Rata-rata durasi membaca dengan Tablet adalah 42.5 menit.
```

### 3. Menemukan Pembaca dengan Rating Tertinggi
**Perintah:**
```sh
awk -F ',' 'NR == 1 {next} {if ($7 > max) {max = $7; name = $2; title = $3}} END {print "Pembaca dengan rating tertinggi:", name, "-", title, "-", max}' reading_data.csv
```
**Cara kerja:**
- Melewati baris pertama (header).
- Menyimpan rating tertinggi dari kolom ke-7 serta nama pembaca (kolom ke-2) dan judul buku (kolom ke-3).
- **Contoh Output:**
```
Pembaca dengan rating tertinggi: John Doe - Book A - 4.9
```

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

**Contoh Output:**
```
Genre paling populer di Asia setelah 2023 adalah Fiction dengan 7 buku.
```

## Cara Menjalankan Skrip

Pastikan file `reading_data.csv` tersedia, lalu jalankan perintah berikut di terminal:

```sh
bash poppo_siroyo.sh
```

Atau jalankan perintah secara terpisah sesuai kebutuhan.

---
Dibuat untuk analisis data membaca menggunakan AWK.


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

**Contoh Output:**
```
=== REGISTER PLAYER ===
Masukkan Email: user@example.com
Masukkan Username: user123
Masukkan Password: ********
Registrasi berhasil!
```

### 2. **Login (login.sh)**
**Tujuan:**
- Memverifikasi login pengguna dengan mencocokkan email dan password yang di-hash.
- Jika valid, menampilkan pesan sukses login.
- Jika tidak valid, menampilkan pesan gagal login.

**Contoh Output:**
```
=== LOGIN PLAYER ===
Masukkan Email: user@example.com
Masukkan Password: ********
Login berhasil! Selamat datang!
```
Atau jika gagal:
```
Login gagal! Email atau password salah.
```

### 3. **Monitoring CPU & RAM (manager.sh)**
**Tujuan:**
- **Monitor CPU:**
  - Mengambil penggunaan CPU saat ini dan menyimpannya ke `core.log`.
- **Monitor RAM:**
  - Mengambil total, digunakan, dan tersedia RAM lalu menyimpannya ke `fragment.log`.
- **Crontab Manager:**
  - Menambahkan atau menghapus job crontab untuk pemantauan CPU dan RAM secara otomatis setiap menit.

**Contoh Output CPU Monitoring:**
```
[2025-03-14 15:00:03] - Core Usage [100%] - Terminal Model [Intel(R) Core(TM) i5-10300H CPU @ 2.50GHz]
```

**Contoh Output RAM Monitoring:**
```
[2025-03-15 23:29:01] - Fragment Usage [17.06%] - Fragment Count [654 MB] - Details [Total: 3838 MB, Available: 3183 MB]
```

### 4. **Terminal Interaktif (terminal.sh)**
**Tujuan:**
- Menyediakan antarmuka menu untuk menjalankan:
  1. Registrasi pengguna (`register.sh`).
  2. Login pengguna (`login.sh`).
  3. Crontab Manager (`manager.sh`).
  4. Keluar dari sistem.

**Contoh Output:**
```
=== Sistem Monitoring Arcaea ===
1. Register
2. Login
3. Crontab Manager
4. Keluar
Pilih menu: 1
```

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
#### Analisis Soal
Pada suatu hari, pengguna diminta membantu seorang teman dalam mempersiapkan tim Pokemon untuk turnamen “Generation 9 OverUsed 6v6 Singles.” Karena tidak memahami meta turnamen, pengguna mendapatkan data dari informan berupa file pokemon_usage.csv. File ini berisi beberapa informasi penting seperti Nama pokemon, Usage%, Raw Usage, Type 1, Type 2, dan Stat Pokemon (HP, Atk, Def, SpAtk, SpDef, Speed)
Agar analisis lebih mudah untuk dilakukan, dibuatlah script pokemon_analysis.sh dengan fitur-fitur berikut:
1. Menampilkan Informasi Pokemon dengan Dominasi Meta Tertinggi (Usage% & Raw Usage).
2. Mengurutkan Data dalam Kolom Tertentu dengan Descending untuk Attribut yang Berbentuk Angka (Usage%, Raw Usage, HP, Atk, Def, SpAtk, SpDef, Speed) dan Alphabetical untuk yang Berbentuk Huruf (nama).
3. Mencari Pokemon Berdasarkan Nama
4. Menyaring Data Berdasarkan Tipe Pokemon (dark, grass, dll)
5. Error Handling jika Terjadi Kesalahan dalam Penulisan Command untuk Menjalankan Program
6. Menampilkan Bantuan untuk Panduan Penggunaan Script
#### Command Dasar
Command dasar yang digunakan meliputi:
1. awk: untuk manipulasi dan  pencarian data dalam format CSV.
2. sort: Untuk mengurutkan data berdasarkan kriteria tertentu.
3. case dan if: Untuk menangani argumen yang diberikan pengguna.
#### Analisis Code
##### **1. Mengunduh file pokemon_usage.csv dalam satu direktori dengan program analisis yang akan dibuat (pokemon_analysis.sh).**
```sh
wget "<link file>" O-pokemon_usage.csv
```
##### **2. Membuat file script dan memberi permission untuk execute**
###### Membuat file script baru
```sh
touch Ubah permission menjadi execute menggunakan perintah sudo +x namafile
```
###### Menambahkan permission untuk exeute
```sh
sudo chmod +x pokemon_analysis.sh
```
###### Mulai mengedit file
```sh
nano pokemon_analysis.sh
```
##### **3. Mulai mngedit file**
###### Awali script pertama dengan hashbang
###### Digunakan di awal skrip Bash untuk menunjukkan bahwa skrip tersebut harus dijalankan menggunakan interpreter Bash
```sh
#!/bin/bash
```
##### Soal A
###### Menampilkan Informasi Pokemon dengan Dominasi Meta Tertinggi (--info)
```sh
FILE="$1"

if [[ "$2" == "--info" ]]; then
highest_usage=$(awk -F',' 'NR>1 {gsub("%", "", $2); if($2+0 > max) {max=$2+0; name=$1}} END {print name, max"%"}' "$FILE")
highest_raw=$(awk -F',' 'NR>1 {if($3+0 > max) {max=$3+0; name=$1}} END {print name, max}' "$FILE")

echo "Pokemon yang paling mendominasi meta saat ini!"
echo "----------------------------------------------------"
echo "Peringkat berdasarkan Usage%: $highest_usage"
echo "Peringkat berdasarkan Raw Usage: $highest_raw"
exit 0
fi
```
1. Menggunakan awk untuk mencari Pokemon dengan nilai Usage% dan Raw Usage tertinggi.
2. Kolom dipisahkan dengan , dan karakter % dihapus untuk konversi nilai numerik.
3. Output:

   
