## FlexWord Word List
FlexWord is a word game built for Reddit. You can play it at r/FlexWord.
This word list powers FlexWord. It’s public on purpose.
There’s no team of expert editors privately deciding what’s a real word and what isn’t. It’s just me, a forklift driver who built a word game. And I need your help keeping it honest.
Got a word to suggest? Disagree with a difficulty rating?
Take it to r/FlexWord and use the Word List flair. That’s where the debates happen.
GitHub Issues are for bugs and code contributions only. Word discussion issues will be closed with a redirect to Reddit.
# How the List Gets Built
The word list isn’t just a flat file I found somewhere. It goes through a pipeline before any word ends up in the game:
	•	ListMerge — Multiple source lists get combined into one raw pile. Duplicates removed.
	•	Raw_Scrubbed — Proper nouns, special characters, anything with no business in a word game gets cut.
	•	Sorted_by_Freq — Words get ranked by how commonly they appear in real writing, using frequency data from wordfreq (Robyn Speer, 2022, CC-BY-SA). Common words are easier, rare words are harder. Nothing arbitrary.
	•	In_Game — The final list. These are the words FlexWord actually uses.
The scripts that run each stage live in the scripts/ folder.
# What to Report via GitHub Issues
	•	A bug in the pipeline scripts
	•	A code contribution or PR
Word suggestions, difficulty debates, “wait, that’s a word?” moments: these all belong on r/FlexWord.
# The Original Source of the List
This repo is forked from Wordnik’s open-source wordlist. Wordnik is a nonprofit. If you find their work useful, they accept donations.