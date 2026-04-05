import 'dart:io';
import 'dart:convert';

void main() async {
  // 1. Setup files
  final inputFile = File('words.json'); // Reading your file
  final outputFile = File('four_letter_words.txt'); // Where the winners go
  
  final sink = outputFile.openWrite();

  print('Processing file...');

  // 2. Read line by line
  await inputFile
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .listen((line) {
        // line looks like: "aargh"
        
        // Step A: Clean up whitespace
        var word = line.trim();
        
        // Step B: Remove the quotes manually
        word = word.replaceAll('"', '');
        
        // Step C: Check if it is 4 letters
        if (word.length == 4) {
          sink.writeln(word);
        }
      })
      .asFuture();

  // 3. Finish up
  await sink.close();
  print('Success! Check four_letter_words.txt');
}
