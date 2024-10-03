#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ch-test-opts
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🟣

# Documentation:
# @raycast.author vdimir

import pyperclip
import sys
import re

from typing import List


def process_input(input: str) -> List[str]:
    """
    Convert:
        2024-08-20 13:58:50 Settings used in the test: --setting1 value1 --setting2 value2 ...
    To:
        setting1='value1' setting2='value2' ...
    """
    data = re.sub(r"^.*?--", "--", input)
    data = re.sub(r"\n.*", "", data)
    data = data.split("--")
    for i, _ in enumerate(data):
        value = data[i].strip()
        if not value:
            continue
        values = value.split(" ")
        if len(values) != 2:
            raise ValueError(f"Invalid input: '{value}'")
        data[i] = f"{values[0]}='{values[1]}' \\"
    return data



def main():
    input = pyperclip.paste()
    result = process_input(input)
    pyperclip.copy("\n".join(result))
    print(f"Copied {len(result)} lines to clipboard")

if __name__ == "__main__":
    try:
        main()
    except ValueError as e:
        print(f"Error: {e}")
        sys.exit(1)
