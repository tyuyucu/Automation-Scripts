from PIL import Image
import os

def resize_images(input_folder, output_folder, width, height):
    # Erstelle den Ausgabeordner, falls er nicht existiert
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Liste alle Dateien im Eingabeordner auf
    files = os.listdir(input_folder)

    for file in files:
        # Verarbeite nur Bilddateien
        if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif')):
            # Bildpfad für die Eingabe und Ausgabe
            input_path = os.path.join(input_folder, file)
            output_path = os.path.join(output_folder, file)

            # Öffne das Bild
            with Image.open(input_path) as img:
                # Skaliere das Bild auf die gewünschten Dimensionen
                resized_img = img.resize((width, height))

                # Speichere das skalierte Bild
                resized_img.save(output_path)

# Beispielaufruf
input_folder = r'C:\Users\Anwender\Desktop\tores'
output_folder = r'C:\Users\Anwender\Desktop\rest'
width = 800
height = 550

resize_images(input_folder, output_folder, width, height)