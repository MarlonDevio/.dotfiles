#!/usr/bin/python3

import os
import shutil
import argparse

def replicate_structure(base_dir, destination_dir):
    # Get the name of the base directory
    base_parent_dir = os.path.basename(base_dir.rstrip('/'))

    # Create the destination .dotfiles directory if it doesn't exist
    os.makedirs(destination_dir, exist_ok=True)
    
    # Iterate through each subdirectory in the base directory
    for child_dir_name in os.listdir(base_dir):
        child_dir_path = os.path.join(base_dir, child_dir_name)
        
        # Ensure we're working with directories only
        if os.path.isdir(child_dir_path):
            # Define the new directory structure inside .dotfiles
            new_base_path = os.path.join(destination_dir, child_dir_name, base_parent_dir)
            os.makedirs(new_base_path, exist_ok=True)
            
            # Copy the directory structure and contents to the new location
            for root, dirs, files in os.walk(child_dir_path):
                # Calculate the relative path from the child_dir to the current root
                relative_path = os.path.relpath(root, child_dir_path)
                new_dir_path = os.path.join(new_base_path, relative_path)
                
                # Create directories in the new structure
                os.makedirs(new_dir_path, exist_ok=True)
                
                # Copy all files from the old structure to the new one
                for file in files:
                    src_file_path = os.path.join(root, file)
                    dest_file_path = os.path.join(new_dir_path, file)
                    
                    # Copy the file if it doesn't already exist in the destination
                    if not os.path.exists(dest_file_path):
                        shutil.copy2(src_file_path, dest_file_path)
                    else:
                        print(f"File {dest_file_path} already exists. Skipping.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Replicate a directory structure with modifications.")
    parser.add_argument("base_dir", help="The base directory to replicate.")
    parser.add_argument("destination_dir", help="The destination directory (e.g., .dotfiles).")

    args = parser.parse_args()
    
    replicate_structure(args.base_dir, args.destination_dir)
