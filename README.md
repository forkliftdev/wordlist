FlexWord Word List
FlexWord is a word game built for Reddit. You can play it at r/flexword.
This is the word list that powers FlexWord. It's public on purpose.
There's no team of expert editors privately deciding what's a real word and what isn't. It's just me — a forklift driver who built a word game — and I need your help keeping it honest.
If a word is in here that shouldn't be, or a perfectly good word is missing, open an issue. That's it. That's the whole contribution process.

How the list gets built
The word list isn't just a flat file I found somewhere. It goes through a pipeline before any word ends up in the game. Here's what that looks like:
1. ListMerge — Multiple source lists get combined into one raw pile. Duplicates get removed.
2. Raw_Scrubbed — The obvious junk gets cleaned out. Proper nouns, words with special characters, anything that has no business being in a word game.
3. Sorted_by_Freq — Words get ranked by how commonly they appear in real writing. This is what powers difficulty in FlexPlay — common words are easier, rare words are harder. Nothing arbitrary.
In_Game — The final list. These are the words FlexWord actually uses.
The scripts that run each stage live in the scripts/ folder if you're curious how it works under the hood.

What to report

A word that's offensive, obscure to the point of unfairness, or just wrong
A common word that's missing and should obviously be there
Anything that made you go "wait, that's a word?"

Open an issue here →

Where this list came from
This repo is forked from Wordnik's open-source wordlist. Wordnik is a nonprofit. If you find their work useful, they accept donations.

