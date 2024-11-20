#!/bin/bash

#-----------------------------MENU-----------------------------#
function menu() {
    clear
    echo "Scegli un'opzione:"
    echo "1) Equazione di primo grado"
    echo "2) Equazione di secondo grado"
    echo "3) Sistema di due equazioni lineari"
    echo "4) Esci"
}

#----------------------------FUNZIONI---------------------------#

function equazione_primo_grado() {
    echo "Inserisci il valore di a:"
    read a
    # nel seguente if notiamo che se il coefficiente a è uguale a 0 da errore #
    if [ "$a" -eq 0 ]; then
        echo "Il coefficiente 'a' non può essere zero."
        return
    fi
    echo "Inserisci il valore di b:"
    read b
    x=$(echo "scale=2; -$b/$a" | bc)
    # soluzione del equazione #
    echo "La soluzione dell'equazione $a x + $b = 0 è: x = $x"
    sleep 2
}

function equazione_secondo_grado() {
    echo "Inserisci il valore di a:"
    read a
    echo "Inserisci il valore di b:"
    read b
    echo "Inserisci il valore di c:"
    read c
    # calcolo del delta #
    D=$(echo "scale=2; ($b^2)-(4*$a*$c)" | bc)
    # se il delta è minore di zero l'equazione non può essere effettuata #
    if [[ $(echo "$D < 0" | bc) -eq 1 ]]; then
        echo "L'equazione non accetta numeri reali."
        return
    fi
    # calcolo della radice quadrata #
    rq=$(echo "scale=2; sqrt($D)" | bc)
    
    b=$((b * -1))
    # se il delta è maggiore di 0 abbiamo due possibili soluzioni per la nostra equazione #
    if [ "$(echo "$D > 0" | bc)" -eq 1 ]; then
        echo "L'equazione ammette due soluzioni reali."
        x1=$(echo "scale=2; ($b + $rq) / (2 * $a)" | bc)
        x2=$(echo "scale=2; ($b - $rq) / (2 * $a)" | bc)
        echo "x1 = $x1"
        echo "x2 = $x2"
    # se il delta è uguale a 0 l'equazione ammette una possibile soluzione per la nostra equazione #   
    elif [ "$(echo "$D == 0" | bc)" -eq 1 ]; then
        echo "L'equazione ammette una soluzione reale ."
        x=$(echo "scale=2; ($b) / (2 * $a)" | bc)
        echo "x = $x"
    else echo "l'equazione non ammette numeri reali.";
    parte_reale=$(echo "scale=2; -$b / (2*$a)" | bc -1)
    parte_immaginaria=$(echo "scale=2; sqrt(-$discriminante) / (2*$a)" ! bc-1)
    echo "L'equazione ha due soluzioni complesse:"
    echo "x1 = $parte_reale + $(parte_immaginaria)i"
    echo "x2 = $parte_reale - $(parte_immaginaria)i"
    fi
    sleep 2
}

function equazioni_lineari() {
    # chiediamo al utente di inserire tre coefficienti per la prima equazione #
    echo "Inserisci i coefficienti della prima equazione (a1, b1, c1):"
    read a1 b1 c1  # Legge i valori in input #

    # chiediamo all'utente di inserire i tre coefficienti per la seconda equazione #
    echo "Inserisci i coefficienti della seconda equazione (a2, b2, c2):"
    read a2 b2 c2  # Legge i valori in input #

    # Calcola il determinante #
    D=$(echo "$a1 * $b2 - $a2 * $b1" | bc)

    # Calcola il determinante Dx per la variabile x #
    Dx=$(echo "$c1 * $b2 - $c2 * $b1" | bc)

    # Calcola il determinante Dy per la variabile y #
    Dy=$(echo "$a1 * $c2 - $a2 * $c1" | bc)

    # Verifichiamo se il determinante D è diverso da 0 #
    if [ "$(echo "$D != 0" | bc)" -eq 1 ]; then
        # clalcola x e y
        x=$(echo "scale=4; $Dx / $D" | bc)  
        y=$(echo "scale=4; $Dy / $D" | bc)  
        # soluzione del sistema #
        echo "La soluzione del sistema è: x = $x, y = $y"
        
    # se la determinante x e la determinante y sono  uguali a 0. il sistema sara indeterminato #  
    elif [ "$(echo "$Dx == 0 && $Dy == 0" | bc)" -eq 1 ]; then
        echo "Il sistema è indeterminato."  
        
    else
        echo "Il sistema è impossibile."  # se è diverso di 0. il sistema sara impossibile. #
    fi

    sleep 2  
}

#-----------------------------MAIN-----------------------------#
# ciclo while che continua a comparire a schermo finche l'utente non farà una scelta #
while true; do
    menu  # Mostra il menu #
    read scelta  # Legge la scelta dell'utente #

    case $scelta in
        1) equazione_primo_grado ;;  # Chiama la funzione per l'equazione di primo grado #
        2) equazione_secondo_grado ;;  # Chiama la funzione per l'equazione di secondo grado #
        3) equazioni_lineari ;;  # Chiama la funzione per risolvere le equazioni lineari #
        4) exit 0 ;;  # uscita dal programma #
        *) echo "Scelta non valida. Riprova." ;;  # nel caso l'utente inserisse un char o qualsiasi altro input diverso da un int il sistema darà scelta non valida #
    esac
done