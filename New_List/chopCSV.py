import csv
import re
# This script takes a csv file of words and splits it into 4 text files based on word length
# It removes all non-alphabetic words and duplicates


INPUT_FILE = "words.csv"

# Output filenames
OUTPUT_FILES = {
    3: "words_3.txt",
    4: "words_4.txt",
    5: "words_5.txt",
    6: "words_6.txt",
}

# Prepare buckets
buckets = {length: [] for length in OUTPUT_FILES}

with open(INPUT_FILE, newline="", encoding="utf-8") as f:
    reader = csv.reader(f)
    for row in reader:
        if not row:
            continue

        word = row[0].strip().lower()

        # Keep only pure alphabetic words
        if not re.fullmatch(r"[a-zA-Z]+", word):
            continue

        length = len(word)
        if length in buckets:
            buckets[length].append(word)

# Write each bucket to its file
for length, filename in OUTPUT_FILES.items():
    with open(filename, "w", encoding="utf-8") as out:
        for word in sorted(set(buckets[length])):
            out.write(word + "\n")

print("Done! Files created:", ", ".join(OUTPUT_FILES.values()))
