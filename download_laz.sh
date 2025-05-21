#!/bin/bash

# Define url of folder to download, and survey
survey="ND_Southwest"
# txt_file_number='3'
url="https://rockyweb.usgs.gov/vdelivery/Datasets/Staged/Elevation/LPC/Projects/ND_SouthWest_2021_D21/ND_SouthWest_1_D21/LAZ/"

# Create folder for downloaded files
output_folder="/gpfs/glad1/Theo/Data/Lidar/LAZ/${survey}"
if [ ! -d "$output_folder" ]; then
    mkdir -p "$output_folder"
fi

# Download the files
cd $output_folder || exit
# wget -nc -c --wait=5 --random-wait --retry-connrefused -i "${survey}${txt_file_number}.txt"
wget -r -nd -nc -c --wait=5 --random-wait -A ".laz" "$url"