#!/bin/bash
#theo kerr 02/20/2024

# Download all files ending in 0.json from GADM database
wget -r -np -nH --cut-dirs=3 -A "*0.json" "https://geodata.ucdavis.edu/gadm/gadm4.1/json" &