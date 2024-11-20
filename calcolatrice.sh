#!/bin/bash

#--------------------------MENU--------------------------------#
function menu() {
    clear
    echo "Scegli un'operazione da eseguire:"
    echo "1) Addizione"
    echo "2) Sottrazione"
    echo "3) Moltiplicazione"
    echo "4) Divisione"
    echo "5) Radice Quadrata"
    echo "6) Elevamento a Potenza"
    echo "7) Media Fattoriale"
    echo "8) Esci"
}

#---------------------------OPERAZIONI------------------------#
function addizione() {
    echo "Inserisci primo numero:"
    read num1
    echo "Inserisci secondo numero:"
    read num2
    echo "Risultato: $((num1 + num2))"
    sleep 2
}

function sottrazione() {
    echo "Inserisci primo numero:"
    read num1
    echo "Inserisci secondo numero:"
    read num2
    echo "Risultato: $((num1 - num2))"
    sleep 2
}

function moltiplicazione() {
    echo "Inserisci primo numero:"
    read num1
    echo "Inserisci secondo numero:"
    read num2
    echo "Risultato: $((num1 * num2))"
    sleep 2
}

function divisione() {
    echo "Inserisci primo numero:"
    read num1
    echo "Inserisci secondo numero:"
    read num2
    if [[ $num2 -ne 0 ]]; then
        echo "Risultato: $((num1 / num2))"
    else
        echo "La divisione per 0 non è effettuabile"
    fi
    sleep 2
}

function radice_quadrata() {
    echo "Inserisci il numero:"
    read num
    if (( $(echo "$num >= 0" | bc -l) )); then
        risultato=$(echo "scale=2; sqrt($num)" | bc)
        echo "La radice quadrata di $num è: $risultato"
    else
        echo "Non è possibile calcolare la radice quadrata di un numero negativo"
    fi
    sleep 2
}

function elevamento_a_potenza() {
    echo "Inserisci il numero:"
    read num
    risultato=$((num * num))  
    echo "Risultato: $risultato"
    sleep 2
}

function calcola_fattoriale() {
    local n=$1
    local fattoriale=1
    for (( i=1; i<=n; i++ )); do
        fattoriale=$((fattoriale * i))
    done
    echo $fattoriale
}

function media_fattoriale() {
    echo "Quanti numeri vuoi inserire?"
    read count
    if [[ $count -le 0 ]]; then
        echo "Devi inserire almeno un numero."
        sleep 2
        return
    fi

    somma=0
    for (( i=1; i<=count; i++ )); do
        echo "Inserisci il numero $i:"
        read num
        if [[ $num -lt 0 ]]; then
            echo "Il fattoriale non è definito per numeri negativi."
            sleep 2
            return
        fi
        fattoriale=$(calcola_fattoriale $num)
        somma=$((somma + fattoriale))
    done

    media=$(echo "scale=2; $somma / $count" | bc)
    echo "La media dei fattoriali è: $media"
    sleep 2
}

#----------------------------SCELTA-------------------#
while true; do
    menu
    read -p "Inserisci la tua scelta (1-8): " operazione
#---------------------MENU----------------------------#
    case $operazione in
        1) addizione ;;
        2) sottrazione ;;
        3) moltiplicazione ;;
        4) divisione ;;
        5) radice_quadrata ;;
        6) elevamento_a_potenza ;;
        7) media_fattoriale ;;
        8) 
            echo "Uscita dal programma. Grazie!"
            break
            ;;
        *)
            echo "Scelta non valida. Inserisci un numero tra 1 e 8."
            sleep 2
            ;;
    esac
done