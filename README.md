# LAPORAN RESMI SOAL MODUL 1 SISOP

## ANGGOTA KELOMPOK
| Nama                           | NRP        |
| -------------------------------| ---------- |
| Shinta Alya Ramadani           | 5027241016 |
| Prabaswara Febrian Winandika   | 5027241069 |
| Muhammad Farrel Rafli Al Fasya | 5027241075 |
### SOAL 1
SOON
### SOAL 2
SOON
### SOAL 3
#### Analisi Soal
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
##### Fungsi on_the_run
```sh
on_the_run() {
    local term_width=$(tput cols)  
    local progress=0
    local bar_size=$((term_width - 15))
```
Fungsi ini menampilkan progress bar animasi dengan nilai progres yang diperbarui secara acak.
###### time_display
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
