#!/bin/bash

python3 - "$1" "$2" <<'END'
import os
import sys
import shutil

from_folder = sys.argv[1]
to_folder = sys.argv[2]
os.makedirs(to_folder, exist_ok=True)

counts = {}
for root, _, files in os.walk(from_folder):
	for file_name in files:
		source = os.path.join(root, file_name)
		if file_name in counts:
			name, ext = os.path.splitext(file_name)
			new_file_name = f"{name}_{counts[file_name]}{ext}"
			counts[file_name] += 1
		else:
			new_file_name = file_name
			counts[file_name] = 1
		dst_path = os.path.join(to_folder, new_file_name)
		shutil.copy2(source, dst_path)
END