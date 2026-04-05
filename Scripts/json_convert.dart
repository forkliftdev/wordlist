import 'dart:io';
import 'dart:convert';

void main() async {
  // 1. Read the JSON file
  final inputFile = File('words.json');
  final outputFile = File('four_letter_words.txt');
  
  print('Reading file...');
  // We read the whole file as one big string first
  final jsonString = await inputFile.readAsString();

  // 2. Parse the JSON
  // This turns '["word", "test"]' into a real Dart List
  final List<dynamic> fullList = jsonDecode(jsonString);
  
  print('Found ${fullList.length} total words. Filtering...');

  final sink = outputFile.openWrite();

  // 3. Filter
  for (final word in fullList) {
    // Ensure it's a string and check length
    if (word is String && word.length == 4) {
      sink.writeln(word);
    }
  }

  await sink.close();
  print('Done! Saved to four_letter_words.txt');
}
