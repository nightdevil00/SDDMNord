#!/bin/bash

# The only OS supported is ArchLinux.
if ! [ -x "$(command -v pacman)" ]; then
    echo "This script only supports ArchLinux."
    exit 1
fi

#Install required dependencies.

sudo pacman -S --noconfirm --needed qt5-quickcontrols2 qt5-graphicaleffects qt5-svg

# Extract the name of the theme from the folder name it's in.
THEME_NAME=$(basename "$PWD")

# Create the theme directory in /usr/share/sddm/themes/
echo "Creating theme directory..."
sudo mkdir -p "/usr/share/sddm/themes/$THEME_NAME"

# Copy files to the theme directory
echo "Copying theme files..."
sudo cp -r ./Assets "/usr/share/sddm/themes/$THEME_NAME/"
sudo cp -r ./Backgrounds "/usr/share/sddm/themes/$THEME_NAME/"
sudo cp -r ./Components "/usr/share/sddm/themes/$THEME_NAME/"
sudo cp ./Main.qml "/usr/share/sddm/themes/$THEME_NAME/"
sudo cp ./metadata.desktop "/usr/share/sddm/themes/$THEME_NAME/"
sudo cp ./theme.conf "/usr/share/sddm/themes/$THEME_NAME/"

# Create sddm.conf at /etc/sddm.conf
echo "Creating sddm.conf..."
echo -e "[Theme]
Current=$THEME_NAME" | sudo tee /etc/sddm.conf > /dev/null

echo "Theme installed successfully!"
