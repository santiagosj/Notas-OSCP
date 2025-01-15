#!/bin/bash

# Variables
TEMPLATE_PATH="/home/kali/Notes/template.md"
NOTES_DIR="/home/kali/Notes"
CATEGORY=$1
DESCRIPTION=$2
DATE=$(date '+%Y-%m-%d')
FILENAME="${DATE}_${DESCRIPTION}.md"
CATEGORY_DIR="$NOTES_DIR/$CATEGORY"
NOTE_PATH="$CATEGORY_DIR/$FILENAME"

# Asegurar que los directorios existen
if [ ! -d "$NOTES_DIR" ]; then
    sudo mkdir -p "$NOTES_DIR"
fi

if [ ! -d "$CATEGORY_DIR" ]; then
   sudo mkdir -p "$CATEGORY_DIR"
fi

# Verificar que el template existe
if [ ! -f "$TEMPLATE_PATH" ]; then
    echo "Template no encontrado en $TEMPLATE_PATH"
    exit 1
fi

# Crear la nota
sudo cp "$TEMPLATE_PATH" "$NOTE_PATH"
sudo nano "$NOTE_PATH"

# Mensaje de commit con el ID de la nota
COMMIT_MESSAGE="Add note: $CATEGORY/$FILENAME"

# Verificar si el repositorio Git está inicializado
if [ -d "$NOTES_DIR/.git" ]; then
    cd "$NOTES_DIR"
    git add "$CATEGORY/$FILENAME"
    git commit -m "$COMMIT_MESSAGE"
    git push origin main
    echo "Nota sincronizada con el repositorio remoto."
else
    echo "El directorio $NOTES_DIR no está configurado como repositorio Git. Configúralo manualmente."
fi

