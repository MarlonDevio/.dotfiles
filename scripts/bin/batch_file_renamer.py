#!/Users/marlon/.pyenv/shims/python3

import os
import re
import sys
from typing import List, Optional


def find_file(pattern: str, filename: str) -> Optional[str]:
    """
    Function to find a matching file
    """
    compiled_pattern = re.compile(pattern)
    match = re.search(compiled_pattern, filename)
    if match:
        return filename
    return None


def get_files_in_dir() -> List[str]:
    """
    Function to get all files in the current directory
    """
    return [f for f in os.listdir() if os.path.isfile(f)]


def retrieve_all_matches_from_filenames(pattern: str) -> List[str]:
    """
    Function to retrieve all matches
    """
    return [filename for filename in get_files_in_dir() if find_file(pattern, filename)]


def extract_file_extension(filename: str) -> str:
    """
    Function to extract file extension
    """
    return filename.split(".")[-1]


def handle_file_renaming(pattern: str, new_file_name: str):
    """
    Function to handle renaming files
    """
    counter = 1
    found_files = retrieve_all_matches_from_filenames(pattern)
    for file in found_files:
        print(file)
        extension = extract_file_extension(file)
        if extension:
            new_name = f"{new_file_name}-{counter}.{extension}"
            os.rename(file, new_name)
            counter += 1


def handle_program():
    """
    Main function to handle the program execution
    """
    try:
        regex_pattern = sys.argv[1]
        new_filename = sys.argv[2]
        handle_file_renaming(regex_pattern, new_filename)
    except IndexError:
        print(
            "Please provide a regex pattern and a new file name eg: python3 renamer [regex_pattern] [new_name]"
        )
        sys.exit(1)


if __name__ == "__main__":
    handle_program()
