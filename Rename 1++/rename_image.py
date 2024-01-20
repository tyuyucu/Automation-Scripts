import os

def rename_images(input_folder):
    # Liste alle Dateien im Eingabeordner auf
    files = os.listdir(input_folder)

    # Zähler für die Nummerierung
    counter = 1

    for file in files:
        # Verarbeite nur Bilddateien
        if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif')):
            # Bildpfad für die Eingabe und Ausgabe
            input_path = os.path.join(input_folder, file)

            # Extrahiere Dateiendung
            _, extension = os.path.splitext(file)

            # Neuer Dateiname mit Nummerierung
            new_name = str(counter) + extension

            # Neuer Bildpfad
            output_path = os.path.join(input_folder, new_name)

            # Umbenenne das Bild
            os.rename(input_path, output_path)

            # Inkrementiere den Zähler
            counter += 1

# Beispielaufruf
input_folder = r'C:\Users\Anwender\Desktop\Resized'

rename_images(input_folder)