#!/bin/bash

# Nom du script : check_mariadb.sh
# Auteur : cherel Johan
# Date de création : 21/12/2023
# Version : 1.0

# Exécute systemctl status et capture la sortie
status=$(systemctl status mariadb 2>&1)

# Fonction d'affichage de l'aide
show_help() {
    cat <<EOF
Usage: $(basename "$0") [-h]

Description :
  Vérifie si le service MariaDB est actif en utilisant 'systemctl status'.

Options :
  -h  Afficher ce message d'aide
EOF
}

# Gestion des options avec getopts
while getopts ":h" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        \?)
            echo "Option invalide : -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Vérifie si le statut contient "Active: active"
if [[ $status == *"Active: active"* ]]; then
    echo "OK - MariaDB fonctionne."
    exit 0  # Code de sortie 0 pour OK
else
    echo "WARNING - MariaDB ne fonctionne pas ou une erreur est survenue."
    echo "Statut : $status"
    exit 1  # Code de sortie 1 pour WARNING
fi
