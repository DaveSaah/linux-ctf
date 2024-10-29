#!/bin/bash

# Loop through each level
for ((i = 1; i <= LEVEL_COUNT; i++)); do
	level="level$i"

	# Check if the level exists before attempting to delete
	if id "$level" &>/dev/null; then
		# Delete the level and its directory
		sudo userdel -r "$level"

		# Check if deletion was successful
		if [ $? -eq 0 ]; then
			echo "$level has been deleted successfully."
		else
			echo "Failed to delete $level."
		fi
	else
		echo "$level does not exist, skipping."
	fi
done

echo "Cleanup complete."
