#!/bin/bash
echo "Installing icons..."
cp -r ./.icons $HOME 
echo "Installing themes..."
cp -r ./.themes $HOME
echo "Installing scripts..."
cp -r ./.local $HOME
echo "Installing configurations"
echo "WARNING!"
echo "This action will overwrite the following configurations if they exist; $(ls -m ./.config)"
read -p "Create backups [b] or Proceed [y/n]?";
if [ $REPLY == "y" ]; then
echo "Installing configurations..."
cp -rf ./.config/* $HOME/.config/
elif [ $REPLY == "b" ]; then
echo "Creating Backups..."
while IFS= read -r string
do 
    mkdir $HOME/.config/"${string}"-BACKUP
    cp -r $HOME/.config/$string/* $HOME/.config/"${string}"-BACKUP
done < <(ls ./.config)
else 
echo "Aborting."
fi
