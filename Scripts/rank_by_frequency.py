# rank_by_frequency.py
import re
from wordfreq import zipf_frequency

IN = "five_letter_words.txt"
OUT = "five_letter_words_ranked.txt"
LOWERCASE = True        # set False to preserve original case
MIN_ALPHA = True        # only keep pure alphabetic tokens

def normalize(w):
    w = w.strip()
    if len(w) >= 2 and ((w[0] == '"' and w[-1] == '"') or (w[0] == "'" and w[-1] == "'")):
        w = w[1:-1]
    return w

words = []
with open(IN, encoding="utf-8") as f:
    for line in f:
        w = normalize(line)
        if LOWERCASE:
            w = w.lower()
        if MIN_ALPHA and not re.fullmatch(r"[a-zA-Z]+", w):
            continue
        if len(w) == 5:
            words.append(w)

# compute zipf frequency (higher = more common)
scored = []
for w in set(words):
    score = zipf_frequency(w, "en")  # returns a float, typical range ~1–7
    scored.append((score, w))

# sort descending by score, then alphabetically
scored.sort(key=lambda x: (-x[0], x[1]))

# write full ranked list with scores
with open(OUT, "w", encoding="utf-8") as f:
    for score, w in scored:
        f.write(f"{score:.3f}\t{w}\n")

# print top 50
print("Top 50 (score, word):")
for score, w in scored[:50]:
    print(f"{score:.3f}\t{w}")

print(f"\nWrote {len(scored)} unique five-letter words to {OUT}")
