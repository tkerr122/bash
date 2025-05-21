#!/bin/bash
#theo kerr on 1/31/2025

# Define folder
root_folder="/gpfs/glad1/Theo/Data/CHM_cleaning/Water"

# Loop through folders, rename files, and move
for folder in "$root_folder"/*; do
	# Generate folder name
	folder_name=$(basename "$folder")
	
	# Rename and move files
	for file in "$folder"/*; do
		mv "$file" "${root_folder}/${folder_name}.tif"
		echo "Moved $file to $root_folder"
	done
done