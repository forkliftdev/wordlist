import re
import sys
from wordfreq import zipf_frequency

# --- User Inputs with Defaults ---
print("--- Frequency Ranker Setup ---")

# Ask for input file
default_in = "three_letter_words.txt"
file_in = input(f"Enter input filename (default: {default_in}): ").strip()
if not file_in:
    file_in = default_in

# Ask for output file
default_out = "ranked_words.txt"
file_out = input(f"Enter output filename (default: {default_out}): ").strip()
if not file_out:
    file_out = default_out

# Ask for word length
default_len = "3"
len_str = input(f"Enter target word length (default: {default_len}): ").strip()
if not len_str:
    target_length = 3
else:
    try:
        target_length = int(len_str)
    except ValueError:
        print(f"Invalid number '{len_str}'. Defaulting to length 3.")
        target_length = 3

print(f"\nProcessing '{file_in}' for {target_length}-letter words...")

# --- Configuration ---
LOWERCASE = True        # set False to preserve original case
MIN_ALPHA = True        # only keep pure alphabetic tokens

def normalize(w):
    w = w.strip()
    # Remove surrounding quotes if present
    if len(w) >= 2 and ((w[0] == '"' and w[-1] == '"') or (w[0] == "'" and w[-1] == "'")):
        w = w[1:-1]
    return w

words = []

try:
    with open(file_in, encoding="utf-8") as f:
        for line in f:
            w = normalize(line)
            if LOWERCASE:
                w = w.lower()
            
            # Skip non-alphabetic tokens if flag is set
            if MIN_ALPHA and not re.fullmatch(r"[a-zA-Z]+", w):
                continue
            
            # Filter by the user-defined length
            if len(w) == target_length:
                words.append(w)
except FileNotFoundError:
    print(f"Error: The file '{file_in}' was not found.")
    sys.exit(1)

if not words:
    print(f"No {target_length}-letter words found in {file_in}.")
    sys.exit(0)

# compute zipf frequency (higher = more common)
scored = []
# Use a set to avoid processing duplicates
for w in set(words):
    score = zipf_frequency(w, "en")  # returns a float, typical range ~1–7
    scored.append((score, w))

# sort descending by score, then alphabetically
scored.sort(key=lambda x: (-x[0], x[1]))

# write full ranked list with scores
try:
    with open(file_out, "w", encoding="utf-8") as f:
        for score, w in scored:
            f.write(f"{score:.3f}\t{w}\n")
except IOError as e:
    print(f"Error writing to file: {e}")
    sys.exit(1)

# print top 50
print(f"\nTop 50 (score, word) for length {target_length}:")
for score, w in scored[:50]:
    print(f"{score:.3f}\t{w}")

print(f"\nSuccess! Wrote {len(scored)} unique {target_length}-letter words to '{file_out}'")