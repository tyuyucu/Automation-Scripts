import os
import shutil

def extract_images_and_remove_empty_folders(source_folder, destination_folder):
    for root, dirs, files in os.walk(source_folder):
        for file in files:
            file_path = os.path.join(root, file)
            shutil.move(file_path, destination_folder)

        for dir in dirs:
            dir_path = os.path.join(root, dir)
            try:
                os.rmdir(dir_path)
                print(f"Empty folder removed: {dir_path}")
            except OSError as e:
                print(f"Error removing folder {dir_path}: {e}")

if __name__ == "__main__":
    source_folder = r"C:\Users\Anwender\Desktop\tilo bilder-20240121T164011Z-001\tilo bilder"  # Pfad zum Ausgangsordner als Raw String
    destination_folder = r"C:\Users\Anwender\Desktop\Neuer Ordner"  # Pfad zum Zielordner als Raw String

    if not os.path.exists(destination_folder):
        os.makedirs(destination_folder)

    extract_images_and_remove_empty_folders(source_folder, destination_folder)

    print("Prozess abgeschlossen.")