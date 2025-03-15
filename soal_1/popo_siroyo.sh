awk -F ',' '$2 == "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca", count, "buku."}' reading_>                                                                                                                  # Output untuk Soal 2                                                                                         awk -F ',' '$8 == "Tablet" {total += $6; count++} END {if (count > 0) print "Rata-rata durasi membaca den>    # Output untuk Soal 3                                                                                         awk -F ',' 'NR == 1 {next} {if ($7 > max) {max = $7; name = $2; title = $3}} END {print "Pembaca dengan r>    # Output untuk Soal 4
    awk -F',' '
NR > 1 {
    # Ambil data sesuai kolom yang benar
    tanggal = $5
    region = tolower($9)
    genre_buku = $4

    # Cek apakah memenuhi syarat (setelah 31 Desember 2023 dan region Asia)
    if (tanggal > "2023-12-31" && region ~ /asia/) {
        genre_count[genre_buku]++
    }
}

END {
    max = 0
    populer = "Tidak ada data"
    
    # Loop untuk mencari genre terbanyak
    for (g in genre_count) {
        if (genre_count[g] > max) {
            max = genre_count[g]
            populer = g
        }
    }

    # Output hasilnya
    if (max > 0) {
        print "Genre paling populer di Asia setelah 2023 adalah", populer, "dengan", max, "buku.";
    } else {
        print "Tidak ada data yang cocok untuk Asia setelah 2023.";
    }
}' reading_data.csv
