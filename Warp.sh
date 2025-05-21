#!/bin/bash
#Theo Kerr on 2/5/2025

# Load GDAL (adjust based on your system)
module load gdal/3.1.0

# Step 1: define i/o folders
input_folder="/gpfs/glad1/Theo/Data/CHM_cleaning/Water_masked"
output_folder="/gpfs/glad1/Theo/Data/CHM_cleaning/Raster_masks/Water_masked"

# Step 2: Create output folder if it doesn't exist
if [ ! -d "$output_folder" ]; then
    mkdir -p "$output_folder"
fi

# Step 3: define variables for the command
srs="EPSG:3857"
res=4.77731426716
threads=50
mem=9000

# Step 4: use gdalwarp
for file in "$input_folder"/*; do
    # Generate output filename
    filename=$(basename "$file")
    output_file="${output_folder}/${filename}"
    if [ -e "$output_file" ]; then
		echo "$filename exists, skipping"
		continue
	fi

    # Warp the file
    gdalwarp -t_srs "$srs" -tr "$res" "$res" -multi -wm "$mem" -wo NUM_THREADS="$threads" -co COMPRESS=LZW -co BIGTIFF=YES "${file}" "${output_file}"
    echo "$filename warped"
done 