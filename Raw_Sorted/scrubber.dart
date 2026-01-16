import 'dart:io';

void main() async {
  // Only processing 3 through 6 as requested
  final filePrefixes = ['3', '4', '5', '6'];
  final StringBuffer scrubDetails = StringBuffer();

  scrubDetails.writeln('Scrub Details Report - ${DateTime.now()}\n');
  scrubDetails.writeln('===================================');

  for (var prefix in filePrefixes) {
    final rawFile = File('${prefix}_Letter.txt');
    final blockFile = File('${prefix}_Block.txt');
    final outputFile = File('${prefix}_valid.txt');

    if (await rawFile.exists() && await blockFile.exists()) {
      // Load files
      final rawWords = (await rawFile.readAsLines())
          .map((w) => w.trim())
          .where((w) => w.isNotEmpty)
          .toList();
      
      final blockWords = (await blockFile.readAsLines())
          .map((w) => w.trim())
          .where((w) => w.isNotEmpty)
          .toSet();

      // Identify which specific words are being removed
      final removedWords = rawWords.where((word) => blockWords.contains(word)).toList();
      
      // Filter the list for the output file
      final validWords = rawWords.where((word) => !blockWords.contains(word)).toList();

      // Write the cleaned x_valid.txt file
      await outputFile.writeAsString(validWords.join('\n'));

      // Append data to the report
      scrubDetails.writeln('FILE: ${prefix}_Letter.txt');
      scrubDetails.writeln('  Initial word count: ${rawWords.length}');
      scrubDetails.writeln('  Words removed:      ${removedWords.length}');
      scrubDetails.writeln('  Final word count:   ${validWords.length}');
      
      if (removedWords.isNotEmpty) {
        scrubDetails.writeln('  List of removed words:');
        scrubDetails.writeln('    ${removedWords.join(", ")}');
      } else {
        scrubDetails.writeln('  No blocked words found.');
      }
      scrubDetails.writeln('-----------------------------------\n');
      
      print('Processed $prefix: Created ${prefix}_valid.txt');
    } else {
      print('Skipping $prefix: Missing ${prefix}_Letter.txt or ${prefix}_Block.txt');
    }
  }

  // Save the detailed report
  await File('scrub_details.txt').writeAsString(scrubDetails.toString());
  print('Scrubbing complete! Summary and removed words list saved to scrub_details.txt');
}