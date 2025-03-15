#!/bin/bash

clear

# fungsi speak to me : buat nampilin woa tiap detik
speak_to_me() {
	while true; do
		curl -s https://www.affirmations.dev | jq -r '.affirmation'
		sleep 1
	done
}

# fungsi on the run
on_the_run() {
    local term_width=$(tput cols)  
    local progress=0
    local bar_size=$((term_width - 15)) 

    echo -e "Let's go on an adventure!\nHold on tight..."

    while [ $progress -lt 100 ]; do
        sleep $(awk -v min=0.1 -v max=1 'BEGIN {srand(); print min+rand()*(max-min)}')

        progress=$((progress + RANDOM % 5 + 1))
        [ $progress -gt 100 ] && progress=100

        filled_size=$((progress * bar_size / 100))

        printf "\r[%s%s] %3d%%" "$(printf '#%.0s' $(seq 1 $filled_size))" "$(printf ' %.0s' $(seq $filled_size $bar_size))" "$progress"
    done
    echo -e "\nMission accomplished!"
}


# fungsi  time = buat nampilin jam real-time nya
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

# fungsi money = buat nampilin efek matrix simbol mata uang
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


# fungsi brain damage = nampilin task manager sederhana
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

# proses input
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
