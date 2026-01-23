#!/bin/sh

# 1) Estrai solo l'ultima occorrenza di SCF Done per ogni file e salva in energia.dat
grep -r "SCF Done" . --include="*.log" --include="*.out" \
  | awk -F: '{key=$1; $1=""; a[key]=$0} END {for (k in a) print k ":" a[k]}' \
  | while IFS=: read -r file testo; do
        cartella=$(basename "$(dirname "$file")")
        echo "$cartella :$testo"
    done > energia.dat

# 2) Aggiungi energia come colonna iniziale, ordina numericamente e salva in energia_sorted.dat
awk -F'=' '{split($2,a," "); energia=a[1]; print energia, $0}' energia.dat \
  | sort -k1,1n \
  | awk '{$1=""; sub(/^ /,""); print}' > energia_sorted.dat
