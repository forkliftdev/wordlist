import 'dart:io';

void main() {
  print('--- Word List Cleaner ---');

  // 1. Get Input Filename
  // stdout.write keeps the cursor on the same line for a cleaner look
  stdout.write('Enter input filename (default: ranked_words.txt): ');
  String inputName = stdin.readLineSync()?.trim() ?? '';
  if (inputName.isEmpty) {
    inputName = 'ranked_words.txt'; // Default
  }

  // 2. Get Output Filename
  stdout.write('Enter output filename (default: clean_words.txt): ');
  String outputName = stdin.readLineSync()?.trim() ?? '';
  if (outputName.isEmpty) {
    outputName = 'clean_words.txt'; // Default
  }

  // 3. Process the file
  final inputFile = File(inputName);
  final outputFile = File(outputName);

  if (!inputFile.existsSync()) {
    print('\nError: Could not find file "$inputName"');
    print('Make sure you are in the folder where the file is located.');
    return; // Stop the script
  }

  print('\nReading from $inputName...');

  try {
    final lines = inputFile.readAsLinesSync();
    final cleanWords = <String>[];

    for (var line in lines) {
      // Logic: Split the line by any whitespace (tab or space)
      // Input looks like: "6.400   about"
      // We want the last part: "about"
      var parts = line.trim().split(RegExp(r'\s+'));
      
      if (parts.length >= 2) {
        // Taking parts.last ensures we get the word even if spacing varies
        cleanWords.add(parts.last);
      }
    }

    // 4. Write the result
    outputFile.writeAsStringSync(cleanWords.join('\n'));
    
    print('Success! Stripped numbers from ${lines.length} lines.');
    print('Clean list saved to: $outputName');

  } catch (e) {
    print('An error occurred: $e');
  }
}