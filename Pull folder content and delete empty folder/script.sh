#!/bin/bash

# Navigieren Sie zu dem Verzeichnis, das die Ordner enthält, bevor Sie dieses Skript ausführen.

# Finde alle Unterordner im aktuellen Verzeichnis
find . -type d -mindepth 1 -maxdepth 1 | while read dir; do
    # Bewege jede Datei in dem Unterordner eine Ebene höher
    find "$dir" -type f -exec mv {} . \;
    
    # Lösche den leeren Unterordner
    rmdir "$dir"
done
