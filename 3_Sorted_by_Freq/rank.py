import re
import os
from wordfreq import zipf_frequency

# Configuration
WORD_LENGTHS = [5]  # Add any other lengths you need (e.g., 4, 6)
LOWERCASE = True
MIN_ALPHA = True

def normalize(w):
    w = w.strip()
    # Remove surrounding quotes if they exist
    if len(w) >= 2 and ((w[0] == '"' and w[-1] == '"') or (w[0] == "'" and w[-1] == "'")):
        w = w[1:-1]
    return w

def process_file(length):
    input_file = f"{length}_valid.txt"
    output_file = f"{length}_freq.txt"
    
    if not os.path.exists(input_file):
        print(f"Skipping: {input_file} not found.")
        return

    words = []
    with open(input_file, "r", encoding="utf-8") as f:
        for line in f:
            w = normalize(line)
            if LOWERCASE:
                w = w.lower()
            
            # Validation: alphabetic only and correct length
            if MIN_ALPHA and not re.fullmatch(r"[a-z]+", w):
                continue
            
            if len(w) == length:
                words.append(w)

    # Use a set to ensure uniqueness before scoring
    unique_words = set(words)
    scored = []
    
    for w in unique_words:
        # Zipf frequency: higher = more common
        score = zipf_frequency(w, "en")
        scored.append((score, w))

    # Sort: Descending by score (-x[0]), then ascending alphabetically (x[1])
    scored.sort(key=lambda x: (-x[0], x[1]))

    # Write results
    with open(output_file, "w", encoding="utf-8") as f:
        for score, w in scored:
            f.write(f"{score:.3f}\t{w}\n")

    print(f"✅ Processed {length}-letter words: {len(scored)} unique entries saved to {output_file}")
    
    # Quick preview of the top 5
    if scored:
        print(f"   Top words: {', '.join([w for score, w in scored[:5]])}")

if __name__ == "__main__":
    for length in WORD_LENGTHS:
        process_file(length)
