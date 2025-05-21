#!/bin/bash

# Load GDAL (adjust based on your system)
module load gdal/3.1.0

# Parse command-line arguments
while getopts "s:" opt; do
  case ${opt} in
    s )
      survey=$OPTARG
      ;;
    \? )
      echo "Usage: sh $0 -s <survey_name>"
      exit 1
      ;;
  esac
done

# Check if survey was provided
if [ -z "$survey" ]; then
  echo "Error: survey name not provided."
  echo "Usage: sh $0 -s <survey_name>"
  exit 1
fi

# Define i/o folders
project_folder="/gpfs/glad1/Theo/Data/Lidar/CHMs_raw"
output_file="${project_folder}/1_Combined_CHMs/${survey}_CHM.vrt"
output_tiff="${project_folder}/1_Combined_CHMs/${survey}_CHM.tif"

# Create VRT
gdalbuildvrt "${output_file}" "${project_folder}/${survey}_CHM"/*.tif

# Create TIFF
gdal_translate -of GTiff -co COMPRESS=LZW -co BIGTIFF=YES "$output_file" "$output_tiff"

# Clean up
rm -f "${output_file}"

echo "${survey} TIFF created"

# ## 2: Only build VRTs
# # Define folder with CHMs
# project_folder="/gpfs/glad1/Theo/Data/Lidar/CHM_cleaning/Cleaned_CHMs"
# vrt_folder="/gpfs/glad1/Theo/Data/Lidar/CHM_cleaning/VRTs"

# output_vrt="${vrt_folder}/CHMs.vrt"

# gdalbuildvrt "$output_vrt" "$project_folder"/*.tif

# echo "$(basename "$output_vrt") created"
