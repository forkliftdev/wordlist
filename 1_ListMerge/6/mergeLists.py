import os
from datetime import datetime

def load_words(path):
    """Load a text file of one word per line into a set."""
    words = set()
    with open(path, encoding="utf-8") as f:
        for line in f:
            w = line.strip().lower()
            if w:
                words.add(w)
    return words

def main():
    # Get current directory name (e.g., "3", "4", "5", "6")
    cwd = os.getcwd()
    folder_name = os.path.basename(cwd)

    try:
        x = int(folder_name)
    except ValueError:
        print(f"Error: Current folder name '{folder_name}' is not a number (3–6).")
        return

    letter_file = f"{x}_letter.txt"
    words_file = f"words_{x}.txt"

    # Check that both files exist
    missing = []
    if not os.path.isfile(letter_file):
        missing.append(letter_file)
    if not os.path.isfile(words_file):
        missing.append(words_file)

    if missing:
        print("Error: Missing expected file(s):")
        for m in missing:
            print("  -", m)
        return

    # Load both lists
    words1 = load_words(letter_file)
    words2 = load_words(words_file)

    # Merge + dedupe
    merged = sorted(words1 | words2)

    # Output filenames
    merged_file = f"{x}_merged.txt"
    info_file = f"info_{x}.txt"

    # Write merged list
    with open(merged_file, "w", encoding="utf-8") as out:
        for w in merged:
            out.write(w + "\n")

    # Write info file
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    with open(info_file, "w", encoding="utf-8") as info:
        info.write(f"Merge date: {now}\n")
        info.write(f"Source file 1: {letter_file} ({len(words1)} words)\n")
        info.write(f"Source file 2: {words_file} ({len(words2)} words)\n")
        info.write(f"Merged unique words: {len(merged)}\n")

    print(f"Done! Created {merged_file} and {info_file}")

if __name__ == "__main__":
    main()
