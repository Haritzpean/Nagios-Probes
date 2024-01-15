#!/bin/bash

# Nom du script : check_ram.sh
# Auteur : cherel Johan
# Date de création : 21/12/2023
# Version : 1.0

# Récupérer l'utilisation de la RAM en pourcentage
ram_used_percentage=$(free | awk '/^Mem:/{print ($3/$2)*100}' | awk '{printf "%.2f\n", $1}')

# Définir les valeurs par défaut des seuils
warning_threshold=70
critical_threshold=85

# Fonction d'affichage de l'aide
show_help() {
    cat <<EOF
Utilisation: $(basename "$0") [-w <seuil_avertissement>] [-c <seuil_critique>]

Options :
  -w <seuil_avertissement>  Définir le seuil d'avertissement pour l'utilisation de la RAM (par défaut : 70)
  -c <seuil_critique>       Définir le seuil critique pour l'utilisation de la RAM (par défaut : 85)
  -h                        Afficher ce message d'aide
EOF
}

# Gestion des options avec getopts
while getopts ":w:c:h" opt; do
    case $opt in
        w)
            warning_threshold=$OPTARG
            ;;
        c)
            critical_threshold=$OPTARG
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            echo "Option invalide : -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "L'option -$OPTARG nécessite un argument." >&2
            exit 1
            ;;
    esac
done

# Vérifier les seuils
if (( $(echo "$ram_used_percentage > $critical_threshold" | bc -l) )); then
    echo "CRITICAL - L'utilisation de la RAM est de ${ram_used_percentage}% (Critique à ${critical_threshold}%)"
    exit 2  # Code de sortie pour CRITICAL
elif (( $(echo "$ram_used_percentage > $warning_threshold" | bc -l) )); then
    echo "WARNING - L'utilisation de la RAM est de ${ram_used_percentage}% (Avertissement à ${warning_threshold}%)"
    exit 1  # Code de sortie pour WARNING
else
    echo "OK - L'utilisation de la RAM est de ${ram_used_percentage}%"
    exit 0  # Code de sortie pour OK
fi
