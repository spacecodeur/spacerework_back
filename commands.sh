#!/bin/bash

# Tableau associatif des commandes
declare -A COMMANDS=(
    ["docker-shell"]="docker exec -it spacerework-back-container /bin/sh"
    ["docker-build"]="docker compose up --build -d"
    ["docker-ls"]="docker images && docker ps -a --size"
    ["docker-clean"]="docker ps -q | xargs -r docker stop && docker ps -aq | xargs -r docker rm -v && docker network prune -f && docker images -q | xargs -r docker rmi"
    ["docker-clean-with-cache"]="docker ps -q | xargs -r docker stop && docker ps -aq | xargs -r docker rm -v && docker network prune -f && docker system prune -af --volumes && docker images -q | xargs -r docker rmi"
)

# Fonction pour afficher l'aide
show_help() {
    echo "Usage: $0 <commande>"
    echo "Commandes disponibles :"
    for cmd in "${!COMMANDS[@]}"; do
        echo "  $cmd"
    done
}

# Fonction pour l'autocomplétion
_commands_autocomplete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(compgen -W "${!COMMANDS[*]}" -- "$cur"))
}

# Détection si le script est sourcé ou exécuté
if [[ "$0" != "${BASH_SOURCE[0]}" ]]; then
    # Activer l'autocomplétion uniquement si sourcé
    complete -F _commands_autocomplete ./commands.sh
else
    # Si exécuté directement, rappeler de sourcer pour l'autocomplétion
    if [[ $1 == "--setup" ]]; then
        echo "Ajout automatique de source dans ~/.bashrc"
        SCRIPT_PATH=$(realpath "$0")
        if ! grep -q "source $SCRIPT_PATH" ~/.bashrc; then
            echo "source $SCRIPT_PATH" >> ~/.bashrc
            echo "Le script a été ajouté à ~/.bashrc. Veuillez exécuter : source ~/.bashrc"
        else
            echo "Le script est déjà présent dans ~/.bashrc"
        fi
        exit 0
    fi

    # Gestion des arguments
    if [[ $# -eq 0 ]]; then
        show_help
        exit 1
    fi

    COMMAND=$1

    # Exécution des commandes
    if [[ -n "${COMMANDS[$COMMAND]}" ]]; then
        eval "${COMMANDS[$COMMAND]}"
    else
        echo "Commande inconnue : $COMMAND"
        show_help
        exit 1
    fi
fi
