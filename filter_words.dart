import 'dart:io';
import 'dart:convert';

void main() async {
  // 1. Setup your files
  final inputFile = File('words.txt'); // Make sure this is your big source list!
  final outputFile = File('six_letter_words.txt');
  
  final sink = outputFile.openWrite();

  print('Filtering out all those other words...');

  // 2. Read, Filter, and Write
  await inputFile
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .listen((line) {
        
        // --- THE FIX IS HERE ---
        
        // 1. Trim whitespace
        var cleanWord = line.trim();
        
        // 2. Remove Quotes and Commas
        cleanWord = cleanWord.replaceAll('"', ''); 
        cleanWord = cleanWord.replaceAll(',', ''); 

        // 3. Now check the length of the REAL word
        if (cleanWord.length == 6) {
          sink.writeln(cleanWord);
        }
        
        // -----------------------
      })
      .asFuture();

  // 3. Cleanup
  await sink.close();
  print('Done!');
}