import 'dart:io';

void main() async {
  // The numbers corresponding to your file prefixes
  final filePrefixes = ['3', '4', '5', '6'];
  final StringBuffer scrubDetails = StringBuffer();

  scrubDetails.writeln('Scrub Details - ${DateTime.now()}\n');
  scrubDetails.writeln('-----------------------------------');

  for (var prefix in filePrefixes) {
    final rawFile = File('${prefix}_answersraw.txt');
    final blockFile = File('${prefix}_Block.txt');
    final outputFile = File('${prefix}_answers.txt');

    if (await rawFile.exists() && await blockFile.exists()) {
      // Read lines and convert to Sets for faster lookup and to remove duplicates
      final rawWords = (await rawFile.readAsLines())
          .map((w) => w.trim())
          .where((w) => w.isNotEmpty)
          .toList();
      
      final blockWords = (await blockFile.readAsLines())
          .map((w) => w.trim())
          .where((w) => w.isNotEmpty)
          .toSet();

      int initialCount = rawWords.length;
      
      // Filter out words found in the block set
      final cleanedWords = rawWords.where((word) => !blockWords.contains(word)).toList();
      
      int removedCount = initialCount - cleanedWords.length;

      // Write the cleaned list to the new file
      await outputFile.writeAsString(cleanedWords.join('\n'));

      // Log the details
      scrubDetails.writeln('File Prefix: $prefix');
      scrubDetails.writeln('  Initial words: $initialCount');
      scrubDetails.writeln('  Words removed: $removedCount');
      scrubDetails.writeln('  Final count:   ${cleanedWords.length}');
      scrubDetails.writeln('-----------------------------------');
      
      print('Processed group $prefix: removed $removedCount words.');
    } else {
      print('Skipping $prefix: Ensure ${prefix}_answersraw.txt and ${prefix}_Block.txt exist.');
    }
  }

  // Write the final scrub_details.txt
  await File('scrub_details.txt').writeAsString(scrubDetails.toString());
  print('\nScrub complete. Check scrub_details.txt for the report.');
}