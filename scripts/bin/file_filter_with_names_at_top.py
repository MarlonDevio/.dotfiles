#!/usr/bin/env python3

import argparse
import os
import sys


def main():
    root_path = os.getcwd()

    parser = argparse.ArgumentParser(description="Create one file from multiple files")

    # arguments
    parser.add_argument(
        "filetype", type=str, help="The file extension to filter against (e.g., .txt)."
    )
    parser.add_argument(
        "filename", type=str, help="The name of the target file to save the data to."
    )
    parser.add_argument(
        "path",
        type=str,
        nargs="?",
        help="Path of the root directory where the filtering should start.",
    )

    args = parser.parse_args()

    file_type = args.filetype
    if file_type[0] != ".":
        sys.exit("File type needs to start with '.'")
    if args.path:
        root_path = args.path

    all_content = ""

    # Recursively find all files
    with open(args.filename, "a", encoding="utf-8") as output_file:
        for root, dirs, files in os.walk(root_path):
            for file in files:
                name, ext = os.path.splitext(file)
                if ext == file_type:
                    file_path = os.path.join(root, file)
                    with open(file_path, "r", encoding="utf-8") as input_file:
                        # Add file name/path as a separator
                        separator = f"\n\n===== {file_path} =====\n\n"
                        content = input_file.read()
                        all_content += separator + content
                        
                        # Write to the output file
                        output_file.write(separator)
                        output_file.write(content)
    
    # Copy to clipboard if the --copy flag is provided
    
    print(f"Content from all {file_type} files has been saved to {args.filename}.")

if __name__ == "__main__":
    main()
