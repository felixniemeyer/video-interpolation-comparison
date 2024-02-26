#!/bin/bash
#
cd $1

# for each model AMT, FILM, GMFSS, IFRNet, IFUNet, M2M, RIFE
for model in AMT FILM GMFSS IFRNet IFUNet M2M RIFE 
do 

	# Find all files matching the pattern and sort them by their number
	files=$(find . -maxdepth 1 -type f -name "${model}*.png" | sort -V)

	# Get the first and last file
	first_file=$(echo "$files" | head -n 1)
	last_file=$(echo "$files" | tail -n 1)

	# Get the timestamps of the first and last files
	first_timestamp=$(stat -c %.3Y "$first_file")
	last_timestamp=$(stat -c %.3Y "$last_file")

	# Remove the comma from timestamps
	first_timestamp=$(echo "$first_timestamp" | tr -d ',')
	last_timestamp=$(echo "$last_timestamp" | tr -d ',')

	# Calculate the time difference in seconds
	time_difference=$((last_timestamp - first_timestamp))

	echo "Processing time [ms] (incl. png encoding) for $model: $time_difference"
done

