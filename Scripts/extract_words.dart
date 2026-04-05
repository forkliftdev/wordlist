import 'dart:io';

void main(List<String> args) async {
  if (args.length != 2) {
    print('Usage: dart extract_words.dart <input_file> <output_file>');
    exit(1);
  }

  final inputFile = File(args[0]);
  final outputFile = File(args[1]);

  if (!await inputFile.exists()) {
    print('Input file does not exist.');
    exit(1);
  }

  final lines = await inputFile.readAsLines();
  final outputLines = <String>[];

  for (final line in lines) {
    final trimmed = line.trim();

    if (trimmed.isEmpty) continue;

    // Split on whitespace (tabs or spaces)
    final parts = trimmed.split(RegExp(r'\s+'));

    if (parts.length >= 2) {
      outputLines.add(parts[1]);
    }
  }

  await outputFile.writeAsString(outputLines.join('\n'));

  print('Done! Wrote ${outputLines.length} words.');
}
