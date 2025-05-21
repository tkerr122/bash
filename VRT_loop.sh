#!/bin/bash

# Load GDAL
module load gdal/3.1.0

# Define folder with CHMs
project_folder="/gpfs/glad1/Theo/Data/Lidar/CHMs_raw"

# Loop through folders in input folder
for folder in "$project_folder"/*; do
	# Generate folder name
    folder_name=$(basename "$folder")
	
	# Filter out the combined folder
	if [[ "$folder_name" == "1_Combined_CHMs" ]]; then
		continue
	fi
	
	# Generate output file
	output_vrt="${project_folder}/1_Combined_CHMs/${folder_name}.vrt"
	output_file="${project_folder}/1_Combined_CHMs/${folder_name}.tif"
	if [ -e "$output_file" ]; then
		echo "$folder_name exists, skipping"
		continue
	fi
	
	# Build VRT and merged TIFF, delete VRT when it's done
	gdalbuildvrt "${output_vrt}" "${project_folder}/${folder_name}"/*.tif
	gdal_translate -of GTiff -co COMPRESS=LZW -co BIGTIFF=YES "${output_vrt}" "${output_file}"
	rm -f "${output_vrt}"
	echo "$folder_name TIFF created"
done

