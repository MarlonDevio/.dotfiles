#!/Users/marlon/.dotfiles/scripts/bin/obsidian-linker/venv/bin/python3


import os
import re

import yaml

# Constants for folder names
VAULT_NAME = "secondbrain"
WORKING_FOLDER = "NewBrain"

# Define the main folders in your Obsidian vault
FOLDER_MAPPING = {
    "Projects": "01-Projects",
    "Areas": "02-Areas",
    "Resources": "03-Resources",
    "References": "04-References",
}

# Frontmatter fields that link to other files and their corresponding target folders
LINK_FIELDS = {
    "project": "Projects",
    "area": "Areas",
    "resource": "Resources",
    "reference": "References",  # Assuming 'reference' is a possible field
}

# Construct Obsidian path
OBSIDIAN_PATH = os.path.expanduser(
    "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/"
)


def find_dir_recursively(start_path, target_dir_name):
    """
    Search for a directory named `target_dir_name` starting from `start_path`.
    Returns the full path to the directory if found, else None.
    """
    for root, dirs, _ in os.walk(start_path):
        if target_dir_name in dirs:
            return os.path.join(root, target_dir_name)
    return None


def parse_frontmatter(file_path):
    """
    Parse the YAML frontmatter of a markdown file.
    Returns a dictionary of the frontmatter data.
    """
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    frontmatter_regex = re.compile(r"^---\n(.*?)\n---\n", re.DOTALL)
    match = frontmatter_regex.match(content)
    if match:
        frontmatter = match.group(1)
        try:
            data = yaml.safe_load(frontmatter)
            return data
        except yaml.YAMLError as e:
            print(f"YAML parsing error in file {file_path}: {e}")
            return {}
    else:
        print(f"No frontmatter found in file {file_path}.")
        return {}


def extract_link_names(link_list):
    """
    Extract the names from a list of Obsidian links.
    Example: ["[[Project1]]", "[[Project2]]"] -> ["Project1", "Project2"]
    """
    names = []
    for link in link_list:
        # Remove [[ and ]]
        clean_link = link.strip().strip("[[").strip("]]")
        names.append(clean_link)
    return names


def append_link_to_file(target_file_path, link_to_append):
    """
    Append a wiki link to the target file if it's not already present.
    """
    if not os.path.exists(target_file_path):
        print(f"Target file {target_file_path} does not exist. Skipping.")
        return

    with open(target_file_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Check if the link already exists (as a whole word)
    if re.search(rf"\[\[{re.escape(link_to_append)}\]\]", content):
        print(
            f"Link [[{link_to_append}]] already exists in {target_file_path}. Skipping."
        )
        return

    # Append the link at the end with a new line
    with open(target_file_path, "a", encoding="utf-8") as f:
        f.write(f"\n[[{link_to_append}]]\n")
    print(f"Appended link [[{link_to_append}]] to {target_file_path}.")


def process_file(file_path, all_folders_paths):
    """
    Process a single markdown file:
    - Parse its frontmatter.
    - For each link field, append a link to this file in the target files.
    """
    frontmatter = parse_frontmatter(file_path)

    if not frontmatter:
        return  # Skip files without frontmatter or with parsing issues

    # Extract the reference name without .md
    reference_name = os.path.splitext(os.path.basename(file_path))[0]

    # Iterate over defined link fields
    for field, target_folder_key in LINK_FIELDS.items():
        linked_items = frontmatter.get(field, [])
        if not linked_items:
            continue  # No links in this field

        # Ensure it's a list
        if isinstance(linked_items, str):
            linked_items = [linked_items]
        elif not isinstance(linked_items, list):
            print(
                f"Unexpected format for field '{field}' in {file_path}. Skipping this field."
            )
            continue

        linked_names = extract_link_names(linked_items)
        for linked_name in linked_names:
            target_folder = FOLDER_MAPPING.get(target_folder_key)
            if not target_folder:
                print(
                    f"No folder mapping found for key '{target_folder_key}'. Skipping."
                )
                continue

            target_folder_path = all_folders_paths.get(target_folder_key)
            if not target_folder_path:
                print(
                    f"Target folder path for '{target_folder_key}' not found. Skipping."
                )
                continue

            target_file_path = os.path.join(
                target_folder_path, f"{linked_name}.md"
            )
            append_link_to_file(target_file_path, reference_name)


def main():
    # Find the vault path
    root_path = OBSIDIAN_PATH
    secondbrain_path = None

    if WORKING_FOLDER:
        secondbrain_path = find_dir_recursively(root_path, WORKING_FOLDER)
    else:
        secondbrain_path = find_dir_recursively(root_path, VAULT_NAME)

    if not secondbrain_path:
        print(
            f"Could not find the vault directory: {WORKING_FOLDER or VAULT_NAME}"
        )
        return

    # Define paths to important folders
    all_folders_paths = {}
    for key, folder_name in FOLDER_MAPPING.items():
        folder_path = os.path.join(secondbrain_path, folder_name)
        if not os.path.exists(folder_path):
            print(f"Required folder does not exist: {folder_path}")
            return
        all_folders_paths[key] = folder_path

    # Process each markdown file in all relevant folders
    for folder_key, folder_path in all_folders_paths.items():
        for root, dirs, files in os.walk(folder_path):
            for file in files:
                if file.endswith(".md"):
                    file_path = os.path.join(root, file)
                    process_file(file_path, all_folders_paths)

    print("Link appending process completed.")


if __name__ == "__main__":
    main()
