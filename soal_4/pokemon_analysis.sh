#!/bin/bash

#Soal A (--info)
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

#Soal B (--sort)
if [[ "$2" == "--sort" ]]; then
    if [[ -z "$3" ]]; then
        echo "Error: no sort option provided" 
        echo "Use -h or --help for more information" 
        exit 1
    fi
 COLUMN="$3"
    case "$COLUMN" in
        "usage") SORT_COL=2;;
        "raw") SORT_COL=3;;
        "name") SORT_COL=1;;
        "hp") SORT_COL=6;;
        "atk") SORT_COL=7;;
        "def") SORT_COL=8;;
        "spatk") SORT_COL=9;;
        "spdef") SORT_COL=10;;
        "speed") SORT_COL=11;;
        *)
            echo "Kolom yang diinput tidak valid! Gunakan: usage, raw, name, hp, atk, def, spatk, spdef, speed"
            exit 1
            ;;
    esac

echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    # Sorting dengan kondisi khusus untuk kolom Nama (ascending), lainnya descending
    if [[ "$COLUMN" == "name" ]]; then
        sort -t',' -k${SORT_COL},${SORT_COL} "$FILE"
    else
        sort -t',' -k${SORT_COL},${SORT_COL}nr "$FILE"
    fi

    exit 0
fi

#Soal C (--grep)
if [[ "$2" == "--grep" ]]; then
    if [[ -z "$3" ]]; then
        echo "Error: no search term provided" 
        echo "Use -h or --help for more information" 
        exit 1
    fi
    POKEMON_NAME="$3"
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    awk -F',' -v name="$POKEMON_NAME" 'NR>1 && tolower($1) ~ tolower(name)' "$FILE" | sort -t',' -k2,2nr
    exit 0
fi

#Soal D (--filter)
if [[ "$2" == "--filter" ]]; then
    if [[ -z "$3" ]]; then
        echo "Error: no search term provided" 
        echo "Use -h or --help for more information" 
        exit 1
    fi 
    TYPE="$3"
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    awk -F',' -v type="$TYPE" 'NR>1 && tolower($4) == tolower(type) || tolower($5) == tolower(type)' "$FILE" | sort -t',' -k2,2nr
    exit 0
fi 

#Soal F
show_help() {
    cat << "CHARIZARD"
                   ___====-_  _-====___
             _--^^^#####//      \\#####^^^--_
          _-^##########// (    ) \\##########^-_
         -############//  |\^^/|  \\############-
       _/############//   (@::@)   \\############\_
      /#############((     \\//     ))#############\
     -###############\\    (oo)    //###############-
    -#################\\  / VV \  //#################-
   -###################\\/      \//###################-
  _#/|##########/\######(   /\   )######/\##########|\#_
 |/ |#/\#/\#/\/  \#/\##\|  (  )  |/##/\#/  \/\#/\#/\#| \|
|/  V  V  `   V  \#\|\  |  |  |     /|/#/  V   '  V  V  \|  
    `   `  `      ` / | |  |  |  | | \   '      '  '   '
                   (  | |  |  |  | |  )
                  __\ | |  |  |  | | /__
                    (vvv(VVV)(VVV)vvv)
 
CHARIZARD
    echo "Panduan Penggunaan"
    echo "----------------------------------------------------"
    echo "Usage: $0 <file.csv> <command> [options]"
    echo ""
    echo "Commands:"
    echo "  --info          : Menampilkan Pokemon dengan Usage% dan Raw Usage tertinggi"
    echo "  --sort <col>    : Mengurutkan data berdasarkan kolom tertentu (usage, raw, name, hp, atk, def, spatk, s>"
    echo "  --grep <name>   : Mencari Pokemon berdasarkan nama"
    echo "  --filter <type> : Menampilkan Pokemon berdasarkan tipe"
    echo "  -h, --help      : Menampilkan help screen ini"
    exit 0
}

# Tampilkan help screen jika argumen kedua adalah -h atau --help
if [[ "$2" == "-h" || "$2" == "--help" ]]; then
    show_help
fi

