#!/opt/homebrew/bin/python3
import os
import sys
import argparse


def main():
    root_path = os.getcwd()

    parser = argparse.ArgumentParser(description="Create one file from multiple files")

    # arguments
    parser.add_argument(
        "filetype", type=str, help="The name of the file to filter against."
    )
    parser.add_argument(
        "filename", type=str, help="The name of the target file to save the data to."
    )
    parser.add_argument(
        "path",
        type=str,
        nargs="?",
        help="Path of the rootdir of where the filtering should start.",
    )

    args = parser.parse_args()

    file_type = args.filetype
    if file_type[0] != ".":
        sys.exit("File type needs to start with '.'")
    if args.path:
        root_path = args.path

    # Recursively find all files
    with open(args.filename, "a", encoding="utf-8") as output_file:
        # Recursively find all files
        for root, dirs, files in os.walk(root_path):
            for file in files:
                name, ext = os.path.splitext(file)
                if ext == file_type:
                    file_path = os.path.join(root, file)
                    with open(file_path, "r", encoding="utf-8") as input_file:
                        output_file.write(
                            f"\n\n--- {file_path} ---\n\n"
                        )  # Optional: Adds the filename before content
                        output_file.write(input_file.read())


if __name__ == "__main__":
    main()
